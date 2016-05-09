//
//  TodoItemsList.swift
//  Todo
//
//  Created by raidi01 on 5/7/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import Foundation
class TodoItemsList {
    private struct Const {
        static let ValueKey = "RecentTodos.Values"
        static let NumberOfTodos = 100
        
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
    
    
}
