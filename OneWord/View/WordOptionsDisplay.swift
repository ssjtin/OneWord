//
//  WordOptionsDisplay.swift
//  OneWord
//
//  Created by Hoang Luong on 26/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class WordOptionsDisplay: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SanFranciscoDisplay-Thin", size: 55)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.layer.borderWidth = 2
        return button
    }()
    
    let spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.style = .gray
        return ai
    }()
    
    let buttonImage = #imageLiteral(resourceName: "checkmarkIcon")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 25
        layer.masksToBounds = true
        configureSubviews()
    }
    
    private func configureSubviews() {
        addSubviewUsingAutoLayout(label, selectButton, spinner)
        
        addSubviewWithConstraints(subview: label, topAnchor: self.topAnchor, centerXAnchor: self.centerXAnchor, width: self.frame.width, height: self.frame.height/2)
        
        addSubviewWithConstraints(subview: selectButton, topAnchor: label.bottomAnchor, centerXAnchor: self.centerXAnchor, width: 50, height: 50)
        selectButton.setBackgroundImage(buttonImage, for: .normal)
        
        selectButton.addSubviewWithConstraints(subview: spinner, topAnchor: selectButton.topAnchor, leadingAnchor: selectButton.leadingAnchor, trailingAnchor: selectButton.trailingAnchor, bottomAnchor: selectButton.bottomAnchor)
    }
    
    func setActiveState(to state: Bool) {
        if state == true {
            UIView.animate(withDuration: 0.6) {
                self.selectButton.alpha = 1
            }
        } else {
            selectButton.alpha = 0
        }
    }
    
    func setLoadingMode(to state: Bool) {
        if state == true {
            spinner.startAnimating()
            selectButton.setBackgroundImage(nil, for: .normal)
        } else {
            spinner.stopAnimating()
            selectButton.setBackgroundImage(buttonImage, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
