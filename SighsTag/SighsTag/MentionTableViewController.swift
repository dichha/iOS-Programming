//
//  MentionTableViewController.swift
//  SighsTag
//
//  Created by raidi01 on 4/13/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class MentionTableViewController: UITableViewController {
    var mentions: [Mentions] = []
    
    
    struct Mentions: CustomStringConvertible{
        var title:String
        var data:[MentionItem]
        var description:String { return "\(title) : \(data)"}
        
    }
    
    enum MentionItem: CustomStringConvertible {
        case Keyword(String)
        case Image(NSURL, Double)
        
        var description: String{
            switch self{
            case .Keyword(let keyword): return keyword
            case .Image(let url, _): return url.path!
            }
        }
        
    }
    
    var tweet: Tweet? {
        didSet{
            title = tweet?.user.screenName
            if let media = tweet?.media {
                mentions.append(Mentions(title: "Images", data: media.map { MentionItem.Image($0.url, $0.aspectRatio) }))
            }
            if let urls = tweet?.urls {
                mentions.append(Mentions(title: "URLs", data: urls.map { MentionItem.Keyword($0.keyword) }))
            }
            if let hashtags = tweet?.hashtags {
                mentions.append(Mentions(title: "Hashtags", data: hashtags.map { MentionItem.Keyword($0.keyword) }))
                
            }
            if let users = tweet?.userMentions {
                mentions.append(Mentions(title: "Users", data: users.map {MentionItem.Keyword($0.keyword) }))
            }
            
            
        }
    }
    
    //MARK: - UITableViewControllerDataSource
    
    private struct Storyboad {
        static let KeywordCellReuseIdentifier = "Keyword Cell"
        static let ImageCellReuseIdentifier = "Image Cell"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) ->Int {
        return mentions.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return mentions[section].data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let mention = mentions[indexPath.section].data[indexPath.row]
        switch mention{
            
        case .Keyword(let keyword):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboad.KeywordCellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = keyword
            return cell
            
        case .Image(let url, let ratio):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboad.ImageCellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
            cell.imageUrl = url
            return cell
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mention = mentions[indexPath.section].data[indexPath.row]
        switch mention {
        case .Image(_, let ratio):
            return tableView.bounds.size.width / CGFloat(ratio)
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    
    
    
    

}
