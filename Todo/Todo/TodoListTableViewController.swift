//
//  TodoListTableViewController.swift
//  Todo
//
//  Created by raidi01 on 4/19/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    //connecting cancel and done buttons to exit segue
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        print("Unwinding")
    }
    //unwind that takes the data that AddTodoItemViewController.swift is holding and pops into the array of todoItems
    
    @IBAction func unwindAndAddToList(segue: UIStoryboardSegue){
        let source = segue.sourceViewController as! AddTodoItemViewController
        let todoItem: TodoItem = source.todoItem
        
        if todoItem.itemName != "" {
            self.todoItems.append(todoItem)
            self.tableView.reloadData()
        }
        
    }
    var todoItems: [TodoItem] = []
    
    
    func loadInitialData(){
        todoItems = [TodoItem(itemName: "Go to optician"),
            TodoItem(itemName: "Finish Paideia Research Paper"),
            TodoItem(itemName: "Do Golf assignment")
        ]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tempCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell")! as UITableViewCell
        let todoItem = todoItems[indexPath.row]
    
        
        //Downcast from UILabel? to UILabel
        let cell = tempCell.textLabel as UILabel!
        cell.text = todoItem.itemName
        
        //cell display function to have a checkmark if the item is finished
        if (todoItem.completed) {
            tempCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        }else{
            tempCell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return tempCell
    }
    
    
    //Marking as complete
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let tappedItem = todoItems[indexPath.row] as TodoItem
        tappedItem.completed = !tappedItem.completed
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
       
    }
}
