//
//  WordPageViewModel.swift
//  OneWord
//
//  Created by Hoang Luong on 26/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WordDetailsViewModel {
    typealias WordValues = (String, Any)
    
    let disposeBag = DisposeBag()
    let word = BehaviorRelay<Word?>(value: nil)
    
    let wordValues = BehaviorRelay<[WordValues]>(value: [WordValues]())
    
    init() {
        word.subscribe(onNext: {
            _ in
            self.parseWordObject()
        }).disposed(by: disposeBag)
    }
    
    private func parseWordObject() {
        guard let currentWord = word.value else { return }
        
        var values = [WordValues]()
        
        values.append(("Definition", currentWord.definition))
        
        if let partOfSpeech = currentWord.partOfSpeech {
            values.append(("Part of speech", partOfSpeech))
        }
        if let examples = currentWord.examples {
            values.append(("Example", examples))
        }
        if let synonyms = currentWord.synonyms {
            values.append(("Synonym", synonyms))
        }
        wordValues.accept(values)
    }
}
