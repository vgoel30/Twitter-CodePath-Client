//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Varun Goel on 3/3/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var timeStamp: UILabel!
    @IBOutlet var retweetsLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    
    @IBOutlet var retweetImage: UIButton!
    
    
    var tweet: Tweet!
    var retweets = 0
    var likes = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setImageWithURL((tweet.user?.profileUrl)!)
        
        
        profileImage.setImageWithURL((tweet.user?.profileUrl)!)
        username.text = tweet.user?.name
        tweetLabel.text = tweet.text
        
        likes = tweet.favoritesCount
        retweets = tweet.retweetCount
        
        likesLabel.text = String(likes)
        retweetsLabel.text = String(retweets) 
        
        timeStamp.text = timeElapsed(tweet.timestamp!.timeIntervalSinceNow)
    }
    
    
    @IBAction func retweetAction(sender: AnyObject) {
        
        TwitterClient.sharedInstance.retweetTweet(["id": tweet.ID!]) { (tweets, error) -> () in
            if (tweets != nil){
                self.retweetsLabel.text = "\(self.retweets+1)"
                self.retweetImage.setImage(UIImage(named: "retweet-on"), forState: UIControlState.Normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
