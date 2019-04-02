//
//  ViewController.swift
//  OneWord
//
//  Created by Hoang Luong on 25/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    var router: MainRouter!
    
    let disposeBag = DisposeBag()
    
    var getWordButton = GetWordButton(frame: .zero)
    var visualEffectView: UIVisualEffectView?
    
    var wordOptionDisplay: WordOptionsDisplay = {
        let display = WordOptionsDisplay(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 250, height: 150)))
        display.alpha = 0
        return display
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "moreIcon"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureRouter()
        bindViewModel()
    }
    
    deinit {
        print("Main VC deallocated")
    }
    
    var buttonCenterYConstraint: NSLayoutConstraint!
    
    private func configureView() {
        view.backgroundColor = UIColor(r: 44, g: 62, b: 80)

        view.addSubviewUsingAutoLayout(getWordButton, settingsButton, wordOptionDisplay)
        
        getWordButton.centerXAnchor.constrain(to: view.centerXAnchor)
        buttonCenterYConstraint = getWordButton.centerYAnchor.constrain(to: view.centerYAnchor)
        getWordButton.widthAnchor.constrain(to: 200)
        getWordButton.heightAnchor.constrain(to: 200)
        getWordButton.layer.cornerRadius = 100
        
        view.addSubviewWithConstraints(subview: settingsButton, topAnchor: view.topAnchor, topConstant: 50, trailingAnchor: view.trailingAnchor, trailingConstant: -25, width: 44, height: 44)
        
        view.addSubviewWithConstraints(subview: wordOptionDisplay, topAnchor: getWordButton.bottomAnchor, topConstant: 20, centerXAnchor: view.centerXAnchor, width: 150, height: 150)
        
        view.addSubview(wordOptionDisplay)
    }
    
    private func animateWordDisplayView(isVisible: Bool) {
        //Don't call animation if constraints already correct
        if isVisible == false {
            guard buttonCenterYConstraint.constant != 0.0 else { return }
        }
        
        UIView.animate(withDuration: 0.6) {
            self.buttonCenterYConstraint.constant = isVisible ? -100 : 0
            self.wordOptionDisplay.alpha = isVisible ? 1 : 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func toggleFetchingData(to mode: Bool) {
        wordOptionDisplay.setLoadingMode(to: mode)
        getWordButton.isUserInteractionEnabled = mode ? false : true
    }
    
    private func configureRouter() {
        router = MainRouter(viewModel: viewModel)
    }
    
    private func addVisualBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = view.frame
        view.addSubview(visualEffectView!)
    }
    
    func removeVisualBlur() {
        visualEffectView?.removeFromSuperview()
        visualEffectView = nil
    }
    
    private func bindViewModel() {
        
        viewModel.isFetchingRandomWord.asObservable().subscribe(onNext: {
            [unowned self] isFetching in
            
            if isFetching == true {
                self.getWordButton.setActiveState(to: false)
            } else {
                self.getWordButton.setActiveState(to: true)
            }
        }).disposed(by: disposeBag)
        
        getWordButton.rx.tap.subscribe({
            [unowned self] _ in
            self.viewModel.fetchRandomWord()
        }).disposed(by: disposeBag)
        
        wordOptionDisplay.selectButton.rx.tap.subscribe({
            [unowned self] _ in
            self.viewModel.fetchDetailsForCurrentWord()
        }).disposed(by: disposeBag)
        
        settingsButton.rx.tap.subscribe({
            [unowned self] _ in
            self.router.route(to: MainRouter.Destination.Settings.rawValue, fromVC: self, parameters: nil)
        }).disposed(by: disposeBag)
        
        viewModel.wordObject.asObservable().subscribe(onNext: {
            [unowned self] word in
            guard let word = word else { return }
            self.addVisualBlur()
            self.router.route(to: MainRouter.Destination.WordDetails.rawValue, fromVC: self, parameters: word)
        }).disposed(by: disposeBag)
        
        viewModel.currentWord.asObservable().bind(to: wordOptionDisplay.label.rx.text).disposed(by: disposeBag)
        
        viewModel.currentWord.asObservable().subscribe(onNext: {
            [unowned self] word in
            if word == "" {
                self.animateWordDisplayView(isVisible: false)
                self.wordOptionDisplay.setActiveState(to: false)
            } else {
                self.animateWordDisplayView(isVisible: true)
                self.wordOptionDisplay.setActiveState(to: true)
            }
        }).disposed(by: disposeBag)
        
        viewModel.isfetchingWordData.asObservable().subscribe(onNext: {
            [unowned self] fetching in
            self.toggleFetchingData(to: fetching)
        }).disposed(by: disposeBag)
        
    }
    
}

