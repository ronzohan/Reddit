//
//  DictionaryHelper.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/29/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class DictionaryHelper {
    static func model<T>(for dictionary: [String: Any]) -> T? where T: Decodable {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            return nil
        }

        let model: T?

        do {
            model = try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint(error)
            model = nil
        }
        
        return  model
    } 
}
