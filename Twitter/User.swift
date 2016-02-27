//
//  User.swift
//  Twitter
//
//  Created by Varun Goel on 2/24/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenname: String?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary){
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        
        let profileImageUrl = dictionary["profile_image_url_https"] as? String
        
        if let profileImageUrl = profileImageUrl{
            profileUrl  = NSURL(string: profileImageUrl)
        }
    }
}
