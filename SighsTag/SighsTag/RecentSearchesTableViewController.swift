//
//  RecentSearchesTableViewController.swift
//  SighsTag
//
//  Created by raidi01 on 4/27/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class RecentSearchesTableViewController: UITableViewController {
    //MARK: - life cycle
    //contents of user defaults will change only when table view is offscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Table View data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return RecentSearches().values.count
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "History Cell"
        static let SegueIdentifier = "Show Search"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = RecentSearches().values[indexPath.row]
        return cell
    }
    //MARK: - Navigation 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == Storyboard.SegueIdentifier {
                if let ttvc = segue.destinationViewController as? TweetTableViewController {
                    if let cell = sender as? UITableViewCell {
                        ttvc.searchText = cell.textLabel?.text
                    }
                }
            }
        }
    }
    
}
