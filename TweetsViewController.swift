//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Varun Goel on 2/26/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    //the array of tweets
    var tweets:[Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text)
            }
            }, failure:  { (error: NSError) -> () in
                print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
