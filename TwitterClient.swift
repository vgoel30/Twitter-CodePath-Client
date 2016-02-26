//
//  TwitterClient.swift
//  Twitter
//
//  Created by Varun Goel on 2/25/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    //creating the request thing
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "beOYFWoM6lqaG2nOquGKvkymR", consumerSecret: "zjWx1smWLBjUuZgFyVhuzLnNRk0km4x0a8RVnR31WI9YP7uUOb")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) ->  ())?
    
    //login function
    func login(success: () ->(), failure: (NSError) -> () ){
        loginSuccess = success
        loginFailure = failure
        
        //log out first
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            
            //open the URL
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure!(error)
        }
    }
    
    //function for opening the URL
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!)
            -> Void in
            
            self.loginSuccess?()
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure!(error)
        }
    }
    
    //dieclaring the closure
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> () ){
        //calling the closure
        
        
        //GETTING THE USER'S HOME TIMELINE
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (NSURLSessionDataTask,response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (NSURLSessionDataTask,error: NSError) -> Void in
                failure(error)
        })
    }
    
    
    func currentAcount(){
        //VERIFYING THE CREDENTIALS AND GETTING THE USER'S NAME AND STUFF
        GET("1.1/account/verify_credentials.json", parameters: nil, success: { (NSURLSessionDataTask,response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            }, failure: { (NSURLSessionDataTask,error: NSError) -> Void in
                
        })
    }
    
    
}
