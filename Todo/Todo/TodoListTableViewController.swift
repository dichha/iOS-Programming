//
//  TodoListTableViewController.swift
//  Todo
//
//  Created by raidi01 on 5/5/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    var todoItems: [TodoItem]
 = []
    //load initial data
    
    func loadInitialData(){
        
        todoItems = [
            TodoItem(itemName: "Go to the optician"),
            TodoItem(itemName: "Go for exercise"),
            TodoItem(itemName: "Sleep")
        ]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loading initial data
        loadInitialData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
//        print("Unwinding")
    }
    
    @IBAction func unwindAndAddToList(segue: UIStoryboardSegue){
        let source = segue.sourceViewController as! AddTodoItemViewController
        let todoItem:TodoItem = source.todoItem
        
        if todoItem.itemName != "" {
            self.todoItems.append(todoItem)
            self.tableView.reloadData()
        }
        

        
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tempcell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell")! as UITableViewCell
        let todoItem = todoItems[indexPath.row]
        
        //Downcast from UILabel? to UILabel
        let cell = tempcell.textLabel as UILabel!
        cell.text = todoItem.itemName
        
        
        //modifying tableViewCell to have a checkmark
        if (todoItem.completed){
            tempcell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        }else{
            tempcell.accessoryType = UITableViewCellAccessoryType.None
        }

        return tempcell
    }
    
    //MARK: - MarkItem as Complete
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let tappedItem = todoItems[indexPath.row] as TodoItem
        tappedItem.completed = !tappedItem.completed
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
