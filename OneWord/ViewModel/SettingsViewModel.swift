//
//  UserSettingsViewModel.swift
//  OneWord
//
//  Created by Hoang Luong on 31/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Setting: String {
    case MinimumLetters
    case MaximumLetters
    case MinimumFrequency
    case MaximumFrequency
}
class SettingsViewModel {
    
    typealias SettingsTuple = (name: Setting, minValue: Float, maxValue: Float, description: String)
    
    var minimumLetters: BehaviorRelay<Int>
    var maximumLetters: BehaviorRelay<Int>
    var minimumFrequency: BehaviorRelay<Float>
    var maximumFrequency: BehaviorRelay<Float>
    
    var settings = [SettingsTuple]()
    
    init() {
        settings.append((Setting.MinimumLetters, 4.0, 15.0, ""))
        settings.append((Setting.MaximumLetters, 4.0, 15.0, ""))
        settings.append((Setting.MinimumFrequency, 2.0, 7.0, "Lower frequency indicates words that are less commonly used"))
        settings.append((Setting.MaximumFrequency, 2.0, 7.0, "Higher frequency indicates words that are used more often"))
        
        minimumLetters = BehaviorRelay<Int>(value: UserDefaults.standard.savedIntValue(for: Setting.MinimumLetters))
        maximumLetters = BehaviorRelay<Int>(value: UserDefaults.standard.savedIntValue(for: Setting.MaximumLetters))
        minimumFrequency = BehaviorRelay<Float>(value: UserDefaults.standard.savedFloatValue(for: Setting.MinimumFrequency))
        maximumFrequency = BehaviorRelay<Float>(value: UserDefaults.standard.savedFloatValue(for: Setting.MaximumFrequency))
    }
    
    func saveSettings() -> UIAlertController? {
        guard maximumLetters.value >= minimumLetters.value else {
            return UIViewController.constructAlert(withTitle: "Error saving settings", message: "Maximum letters must be greater than minimum letters")
            }
        guard maximumFrequency.value > minimumFrequency.value else {
            return UIViewController.constructAlert(withTitle: "Error saving settings", message: "Maximum frequency must be greater than minimum frequency")
            
        }
        UserDefaults.standard.setValue(minimumLetters.value, forKey: Setting.MinimumLetters.rawValue)
        UserDefaults.standard.setValue(maximumLetters.value, forKey: Setting.MaximumLetters.rawValue)
        UserDefaults.standard.setValue(minimumFrequency.value, forKey: Setting.MinimumFrequency.rawValue)
        UserDefaults.standard.setValue(maximumFrequency.value, forKey: Setting.MaximumFrequency.rawValue)
        
        return nil
    }

}
