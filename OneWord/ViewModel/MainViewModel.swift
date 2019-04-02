//
//  MainViewModel.swift
//  OneWord
//
//  Created by Hoang Luong on 26/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel {
    
    let manager = APIManager()
    
    let currentWord = BehaviorRelay<String>(value: "")
    
    let wordObject = BehaviorRelay<Word?>(value: nil)
    
    let isFetchingRandomWord = BehaviorRelay<Bool>(value: false)
    
    let isfetchingWordData = BehaviorRelay<Bool>(value: false)
    
    init() {}
    
    func fetchRandomWord() { 
        currentWord.accept("")
        isFetchingRandomWord.accept(true)
        let requestTimeLimit = Date().timeIntervalSince1970 + 5
        
        manager.fetchRandomWord { (word, error) in
            if let word = word {
                self.currentWord.accept(word)
                self.isFetchingRandomWord.accept(false)
            } else {
                //handle error fetching word
                guard Date().timeIntervalSince1970 < requestTimeLimit else {
                    print("timed out")
                    return }
                print(error!.localizedDescription)
                self.fetchRandomWord()
            }
        }
    }
    
    func fetchDetailsForCurrentWord() {
        isfetchingWordData.accept(true)
        manager.fetchData(for: currentWord.value) { (json, error) in
            if let json = json {
                self.isfetchingWordData.accept(false)
                self.wordObject.accept(self.manager.evaluateJSONData(data: json))
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
}
