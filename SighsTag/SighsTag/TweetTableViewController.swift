//
//  TweetTableViewController.swift
//  SighsTag
//
//  Created by raidi01 on 4/6/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {
    var tweets =  [[Tweet]]() //arrays of arrays of tweets because each array will be a section of tweets
    var searchText: String? = "#luthercollege"{
        //when searchText is set clear out the table and refresh
        didSet{
            lastSuccessfulRequest = nil //since when new request is done old one does not matter
            searchTextField?.text = searchText
            tweets.removeAll()
            tableView.reloadData()//blank out the table view
            refresh()
        }
    }
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //autimatic height calculation
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
    }
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
        
    }
    var lastSuccessfulRequest: TwitterRequest?
    var nextRequestToAttempt: TwitterRequest? {
        if lastSuccessfulRequest == nil{
            if searchText != nil{
                return TwitterRequest(search: searchText!, count: 100)
            }else{
                return nil
            }
        }else{
            return lastSuccessfulRequest!.requestForNewer
        }
    }
    
    func refresh(){
        if refreshControl != nil{
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
        
    }
    
    @IBAction func refresh(sender: UIRefreshControl?) {
        if searchText != nil{
            if let request = nextRequestToAttempt {
                request.fetchTweets{(newTweets) -> Void in
                    dispatch_async(dispatch_get_main_queue()){() -> Void in
                        if newTweets.count > 0{
                            self.lastSuccessfulRequest = request
                            self.tweets.insert(newTweets, atIndex: 0) //inserting into a 1st section
                            self.tableView.reloadData()
                            //a work around for disclosure indicator is to force a reload of all sections on addition to reload just a data
                            self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, self.tableView.numberOfSections)), withRowAnimation: .None)
                            sender?.endRefreshing()
                            //setting the current search text as title
                            self.title = self.searchText
                        }
                    }
                }
            }
            
        }else{
          sender?.endRefreshing() 
        }
        

        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField{
            textField.resignFirstResponder()//dismiss the keyboard
            searchText = textField.text
            
        }
        return true
    }
    //MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
        
    }
    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
        static let MentionsIndentifier = "Show Mentions"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell
        
        //configure the cell...
//        let tweet = tweets[indexPath.section][indexPath.row]
//        cell.textLabel?.text = tweet.text
//        cell.detailTextLabel?.text = tweet.user.name
        cell.tweet = tweets[indexPath.section][indexPath.row]
        return cell
    }
    
    
    //preventing segue from disclosure indicator with no details
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        //print(identifier)
        if identifier == Storyboard.MentionsIndentifier {
        //if identifier == "Show Mentions"{
            if let tweetCell = sender as? TweetTableViewCell{
                if tweetCell.tweet!.hashtags.count + tweetCell.tweet!.urls.count + tweetCell.tweet!.userMentions.count + tweetCell.tweet!.media.count == 0{
                    return false
                    
                }
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            if identifier == Storyboard.MentionsIndentifier{
                if let mtvc  = segue.destinationViewController as? MentionsTableViewController{
                    if let tweetCell = sender as? TweetTableViewCell{
                         mtvc.tweet = tweetCell.tweet
                    }
                   
                }
            }
        }
    }

}
