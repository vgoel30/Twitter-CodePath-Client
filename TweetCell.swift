//
//  TweetCell.swift
//  Twitter
//
//  Created by Varun Goel on 2/26/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var thumbImageView: UIImageView!
    
    
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    
    @IBOutlet var retweetCount: UILabel!
    
    @IBOutlet var likeCount: UILabel!
    
    var tweet: Tweet!{
        didSet{
          retweetCount.text = String(tweet.retweetCount)
        likeCount.text = String(tweet.favoritesCount)
            
            tweetLabel.text = tweet.text
            nameLabel.text = tweet.user?.name
            timeLabel.text = timeElapsed(tweet.timestamp!.timeIntervalSinceNow)
            thumbImageView.setImageWithURL((tweet.user?.profileUrl)!)
        }
    }
    
    
    //when the retweet button is clicked
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweetTweet(["id": tweet.ID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                self.likeButton.setImage(UIImage(named: "like-on"), forState: UIControlState.Normal)
                let totalLikes = Int(self.likeCount.text!)! + 1
                self.likeCount.text = String(totalLikes)
            }
        }
    }
    
    //when the like button is clicked
    @IBAction func onLike(sender: AnyObject) {
        TwitterClient.sharedInstance.likeTweet(["id": tweet.ID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                self.likeButton.setImage(UIImage(named: "like-on"), forState: UIControlState.Normal)
                let totalLikes = Int(self.likeCount.text!)! + 1
                self.likeCount.text = String(totalLikes)
            }
        }
    }
    
    
   
    
    
    
    //helper method that returns the total time elapsed since the thweet
    func timeElapsed(elapsed: NSTimeInterval) -> String {
        let time = -Int(elapsed)
        var before = 0
        var timeUnit = ""
        
        //seconds before
        if (time <= 60) {
            before = time
            timeUnit = "s"
        }
            //minutes before
        else if ((time/60) <= 60) {
            before = time/60
            timeUnit = "m"
        }
            
            //hours before
        else if (time/60/60 <= 24) {
            before = time/60/60
            timeUnit = "h"
        }
            
            //days before
        else if (time/60/60/24 <= 365) {
            before = time/60/60/24
            timeUnit = "d"
            
        }
            
            //years before
        else if (time/(3153600) <= 1) {
            before = time/60/60/24/365
            timeUnit = "y"
        }
        
        return "\(before)\(timeUnit)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
