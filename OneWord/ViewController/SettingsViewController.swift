//
//  SettingsViewController.swift
//  OneWord
//
//  Created by Hoang Luong on 31/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UITableViewController {
    
    let viewModel = SettingsViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        bindViewModel()
    }
    
    deinit {
        print("Settings VC deallocated")
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save changes", style: .plain, target: nil, action: nil)
    }
    
    private func bindViewModel() {
        navigationItem.leftBarButtonItem?.rx.tap.subscribe({
            [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap.subscribe({
            [unowned self] _ in
            if let alert = self.viewModel.saveSettings() {
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Settings saved successfully", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsCell
        
        let setting = viewModel.settings[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.settingLabel.text = setting.name.rawValue
        cell.descriptionLabel.text = setting.description
        cell.slider.minimumValue = setting.minValue
        cell.slider.maximumValue = setting.maxValue
        cell.slider.setValue(UserDefaults.standard.savedFloatValue(for: setting.name), animated: true)
        
        switch setting.name {
            
        case .MinimumLetters:
            cell.slider.rx.value.subscribe(onNext: {
                [unowned self] value in
                self.viewModel.minimumLetters.accept(Int(value.rounded(.toNearestOrAwayFromZero)))
            }).disposed(by: disposeBag)
            
            viewModel.minimumLetters.asObservable().subscribe(onNext: {
                number in
                cell.numberLabel.text = String(number)
            }).disposed(by: disposeBag)
            
        case .MaximumLetters:
            cell.slider.rx.value.subscribe(onNext: {
                [unowned self] value in
                self.viewModel.maximumLetters.accept(Int(value.rounded(.toNearestOrAwayFromZero)))
            }).disposed(by: disposeBag)
            
            viewModel.maximumLetters.asObservable().subscribe(onNext: {
                number in
                cell.numberLabel.text = String(number)
            }).disposed(by: disposeBag)
            
        case .MinimumFrequency:
            cell.slider.rx.value.subscribe(onNext: {
                [unowned self] value in
                self.viewModel.minimumFrequency.accept(value)
            }).disposed(by: disposeBag)
            
            viewModel.minimumFrequency.asObservable().subscribe(onNext: {
                number in
                cell.numberLabel.text = String(format: "%.02f", number)
            }).disposed(by: disposeBag)
            
        case .MaximumFrequency:
            cell.slider.rx.value.subscribe(onNext: {
                [unowned self] value in
                self.viewModel.maximumFrequency.accept(value)
            }).disposed(by: disposeBag)
            
            viewModel.maximumFrequency.asObservable().subscribe(onNext: {
                number in
                cell.numberLabel.text = String(format: "%.02f", number)
            }).disposed(by: disposeBag)

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}
