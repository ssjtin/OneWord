//
//  UserDefault_Extension.swift
//  OneWord
//
//  Created by Hoang Luong on 1/4/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    func savedFloatValue(for setting: Setting) -> Float {
        return value(forKey: setting.rawValue) as? Float ?? 0.0
    }
    
    func savedIntValue(for setting: Setting) -> Int {
        return value(forKey: setting.rawValue) as? Int ?? 0
    }
    
    
}
