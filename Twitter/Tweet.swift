//
//  Tweet.swift
//  Twitter
//
//  Created by Varun Goel on 2/24/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text:  NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
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
