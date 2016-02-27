//
//  Tweet.swift
//  Twitter
//
//  Created by Varun Goel on 2/24/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    
    var text:  String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    var profileUrl: NSURL?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
        let imageURL = dictionary["profile_image_url_https"] as? String
        if let imageURL = imageURL{
            profileUrl = NSURL(string: imageURL)
        }
    }
    
    class func tweetsWithArray(dictionaies: [NSDictionary]) -> [Tweet]{
        var  tweets = [Tweet]()
        
        for dictionary in dictionaies{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets 
    }
    
}
