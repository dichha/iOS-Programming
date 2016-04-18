//
//  TweetTableViewCell.swift
//  SighsTag
//
//  Created by raidi01 on 4/6/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit
//public API for cellView

class TweetTableViewCell: UITableViewCell {
    var tweet: Tweet?{
        didSet{
            updateUI()
        }
    }
    
    //public properties to choose a color for the keyword type
    var hashtagColor = UIColor.magentaColor()
    var urlColor = UIColor.orangeColor()
    var userMentionColor = UIColor.purpleColor()

   
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    func updateUI(){
        //reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil                           
        //load new information from out tweet (if any)
        if let tweet = self.tweet{
//            tweetTextLabel?.text = tweet.text
//            if tweetTextLabel?.text != nil{
//                for _ in tweet.media{
//                    tweetTextLabel.text! += "📷"
//                }
            var text = tweet.text
            
            for _ in tweet.media{
                text! += "📷"
            }
            
            
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.changeKeywordsColor(tweet.hashtags,  color: hashtagColor)
            attributedText.changeKeywordsColor(tweet.urls, color: urlColor)
            attributedText.changeKeywordsColor(tweet.userMentions, color: userMentionColor)
            
            //attributedText.changeKeywordsColor(tweet.media, color: urlColor)
            
            
            
            
            tweetTextLabel?.attributedText = attributedText
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL{
                if let imageData = NSData(contentsOfURL: profileImageURL){
                    //blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60{
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            }else{
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
            
            
            if tweet.hashtags.count + tweet.urls.count + tweet.userMentions.count + tweet.media.count > 0 {
                accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }else{
                accessoryType = UITableViewCellAccessoryType.None
            }
        }
    }
    
}
    
    
    

// MARK: - Extensions

private extension NSMutableAttributedString{
    func changeKeywordsColor(keywords: [Tweet.IndexedKeyword], color: UIColor){
        for keyword in keywords{
            addAttribute(NSForegroundColorAttributeName, value: color, range: keyword.nsrange)
        }
    }
}
