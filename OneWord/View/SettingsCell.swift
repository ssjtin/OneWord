//
//  SettingsCell.swift
//  OneWord
//
//  Created by Hoang Luong on 31/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    let settingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .right
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubviewUsingAutoLayout(settingLabel, descriptionLabel, numberLabel, slider)
        
        addSubviewWithConstraints(subview: settingLabel, topAnchor: self.topAnchor, leadingAnchor: self.leadingAnchor, leadingConstant: 20, height: 44)
        
        addSubviewWithConstraints(subview: descriptionLabel, topAnchor: slider.bottomAnchor, leadingAnchor: self.leadingAnchor, trailingAnchor: self.trailingAnchor, trailingConstant: -20, width: self.frame.width, height: 22)
        
        addSubviewWithConstraints(subview: numberLabel, topAnchor: self.topAnchor, leadingAnchor: slider.leadingAnchor, trailingAnchor: slider.trailingAnchor, height: 22)
        
        addSubviewWithConstraints(subview: slider, topAnchor: numberLabel.bottomAnchor, leadingAnchor: settingLabel.trailingAnchor, trailingAnchor: self.trailingAnchor, trailingConstant: -25, width: 200, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
