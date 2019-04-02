//
//  DetailCell.swift
//  OneWord
//
//  Created by Hoang Luong on 28/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30 )
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    let mainLabel: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = UIColor.black
        tv.textAlignment = .center
        tv.backgroundColor = UIColor.clear
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        configureSubviewProperties()
    }
    
    private func configureSubviewProperties() {
        containerView.layer.cornerRadius = 25
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.masksToBounds = true
        
        containerView.backgroundColor = UIColor(r: 52, g: 152, b: 219)
    }
    
    private func setupSubviews() {
        addSubviewUsingAutoLayout(containerView)
        addSubviewWithConstraints(subview: containerView, leadingAnchor: self.leadingAnchor, leadingConstant: 50, trailingAnchor: self.trailingAnchor, trailingConstant: -50, bottomConstant: -100, centerYAnchor: self.centerYAnchor, height: 300)
        
        containerView.addSubviewUsingAutoLayout(doneButton, wordLabel, headerLabel, mainLabel)
        containerView.addSubviewWithConstraints(subview: doneButton, topAnchor: containerView.topAnchor, topConstant: 5, trailingAnchor: containerView.trailingAnchor, trailingConstant: -5, width: 44, height: 44)
        containerView.addSubviewWithConstraints(subview: wordLabel, topAnchor: containerView.topAnchor, topConstant: 20, leadingAnchor: containerView.leadingAnchor, leadingConstant: 25, trailingAnchor: doneButton.leadingAnchor, height: 55)
        containerView.addSubviewWithConstraints(subview: headerLabel, topAnchor: wordLabel.bottomAnchor, topConstant: 30, leadingAnchor: containerView.leadingAnchor, trailingAnchor: containerView.trailingAnchor, height: 44)
        containerView.addSubviewWithConstraints(subview: mainLabel, topAnchor: headerLabel.bottomAnchor, topConstant: 20, leadingAnchor: headerLabel.leadingAnchor, leadingConstant: 20, trailingAnchor: headerLabel.trailingAnchor, trailingConstant: -20, bottomAnchor: containerView.bottomAnchor, bottomConstant: -20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
