//
//  APIManager.swift
//  OneWord
//
//  Created by Hoang Luong on 26/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIManager {
    
    enum FetchError: Error {
        case MissingResults
    }
    
    func fetchRandomWord(completion: @escaping (String?, Error?) -> ()) {
        
        let frequencyMax = UserDefaults.standard.savedFloatValue(for: Setting.MaximumFrequency)
        let frequencyMin = UserDefaults.standard.savedFloatValue(for: Setting.MinimumFrequency)
        let lettersMax = UserDefaults.standard.savedIntValue(for: Setting.MaximumLetters)
        let lettersMin = UserDefaults.standard.savedIntValue(for: Setting.MinimumLetters)
        
        let lettersUrlFragment = "letterpattern=%5E%5CS*%24&lettersMin=" + String(lettersMin) + "&lettersMax=" + String(lettersMax)
        let frequencyUrlFragment = "&frequencymax=" + String(format: "%.02f", frequencyMax) + "&frequencymin=" + String(format: "%.02f", frequencyMin)
        let endUrlFragment = "&random=true&hasDetails=definition,examples,partOfSpeech"
        let url = randomWordUrlString + lettersUrlFragment + frequencyUrlFragment + endUrlFragment
        print(url)
        performNetworkCall(url: url, timeOut: 10) { (json, error) in
            guard let json = json, let word = json["word"].string else {
                completion(nil, FetchError.MissingResults)
                return
            }
            completion(word, nil)
        }
    }
    
    func fetchData(for word: String, completion: @escaping (JSON?, Error?) -> ()) {
        
        var url = specificWordUrlString + word
        url.decodeForUrl()
        performNetworkCall(url: url, timeOut: 10) { (json, error) in
            completion(json, error)
        }
    }
    
    func performNetworkCall(url: String, timeOut: TimeInterval, completion: @escaping (JSON?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue(API_KEY, forHTTPHeaderField: "X-RapidAPI-Key")
        request.timeoutInterval = timeOut
        
        Alamofire.request(request).validate().responseJSON { (response) in
            completion(JSON(response.result.value as Any), response.result.error)
        }.resume()
        
    }
    
    func evaluateJSONData(data: JSON) -> Word? {
        
        guard let results = data["results"].array else { return nil }
        
        let result: JSON
        //Return first result that has word example usage data, else return first result
        if let resultWithExample = results.first(where: { (json) -> Bool in
            json["examples"].exists()
        }) {
            result = resultWithExample
        } else {
            result = results.first!
        }
        
        let decoder = JSONDecoder()
        
        do {
            let resultData = try result.rawData()
            var wordObject = try decoder.decode(Word.self, from: resultData)
            wordObject.word = data["word"].string!
            return wordObject
        } catch let error {
            print("Error decoding data \(error.localizedDescription)")
            return nil
        }
        
    }
}
