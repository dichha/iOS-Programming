//
//  RecentSearches.swift
//  SighsTag
//
//  Created by raidi01 on 4/28/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import Foundation
//no parent class. accessing the user defaults to get and set its values
class RecentSearches {
    private struct Const {
        static let ValueKey = "RecentSearches.Values"
        static let NumberOfSearches = 100
    }
    private let defaults = NSUserDefaults.standardUserDefaults()
    var values: [String] {
        get {
            return defaults.objectForKey(Const.ValueKey) as? [String] ?? []
            
        }
        set {
            defaults.setObject(newValue, forKey: Const.ValueKey)
        }
    }
    //adding a new value, don't want duplicates,
    func add(search: String) {
        var currentSearches = values
        if let index = currentSearches.indexOf(search){
            currentSearches.removeAtIndex(index)
        }
        //if more than 100 remove last one
        currentSearches.insert(search, atIndex: 0)
        while currentSearches.count > Const.NumberOfSearches {
            currentSearches.removeLast()
        }
        values = currentSearches
    }
}