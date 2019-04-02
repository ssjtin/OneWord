//
//  GetWordButton.swift
//  OneWord
//
//  Created by Hoang Luong on 29/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class GetWordButton: UIButton {
    
    let spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.style = UIActivityIndicatorView.Style.gray
        return ai
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
        configureSpinner()
        setActiveState(to: true)
    }
    
    private func configureButton() {
        backgroundColor = UIColor(r: 236, g: 240, b: 241)
        setTitleColor(UIColor.black, for: .normal)
        layer.masksToBounds = true
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureSpinner() {
        addSubviewUsingAutoLayout(spinner)
        addSubviewWithConstraints(subview: spinner, topAnchor: self.topAnchor, leadingAnchor: self.leadingAnchor, trailingAnchor: self.trailingAnchor, bottomAnchor: self.bottomAnchor)
    }
    
    func setActiveState(to state: Bool) {
        switch state {
        case true:
            spinner.stopAnimating()
            setTitle("Get One Word", for: .normal)
            isEnabled = true
        case false:
            spinner.startAnimating()
            setTitle("", for: .normal)
            isEnabled = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
