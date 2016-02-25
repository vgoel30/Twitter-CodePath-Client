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
    
}
