//
//  MainRouter.swift
//  OneWord
//
//  Created by Hoang Luong on 28/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class MainRouter: Router {
    
    enum Destination: String {
        case WordDetails
        case Settings
    }

    unowned var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func route(to destination: String, fromVC: UIViewController, parameters: Any?) {
        switch destination {
            
        case MainRouter.Destination.WordDetails.rawValue:
            
            guard let word = parameters as? Word else { return }
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let destinationVC = WordDetailsViewController(collectionViewLayout: layout)
            destinationVC.modalPresentationStyle = .overCurrentContext
            destinationVC.modalTransitionStyle = .crossDissolve
            destinationVC.viewModel.word.accept(word)
            fromVC.present(destinationVC, animated: true, completion: nil)
            
        case MainRouter.Destination.Settings.rawValue:
            let vc = UINavigationController(rootViewController: SettingsViewController())
            fromVC.present(vc, animated: true, completion: nil)
        default: ()
            
        }
    
    }
}
