//
//  AddTodoItemViewController.swift
//  Todo
//
//  Created by raidi01 on 4/26/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class AddTodoItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var todoItem: TodoItem = TodoItem(itemName: "")
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(self.textField.text != "") {
            self.todoItem = TodoItem(itemName: self.textField.text!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //making UItextField first responder
        textField.delegate = self
        textField.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
