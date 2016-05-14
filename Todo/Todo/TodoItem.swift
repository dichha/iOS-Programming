//
//  TodoItem.swift
//  Todo
//
//  Created by raidi01 on 5/18/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class TodoItem: NSObject {
    let itemName: String
    var completed: Bool
    
    init(itemName: String, completed: Bool = false) {
        self.itemName = itemName
        self.completed = completed
        
    }

}
