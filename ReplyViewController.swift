//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Varun Goel on 3/2/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var profileImage: UIImageView!
    //@IBOutlet var username: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var screenName: UILabel!
    @IBOutlet var tweetField: UITextField!
    
    @IBOutlet var wordCount: UILabel!
    
   // @IBOutlet var tweetTextView: UITextView!
    
    
    var user: User?
    var tweet: Tweet?
    var count: Int = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tweetField.delegate = self
        tweetField.becomeFirstResponder()
        
        TwitterClient.sharedInstance.currentAcount({ (user: User) -> () in
            self.user = user
            self.profileImage.setImageWithURL(user.profileUrl!)
            self.username.text = "\(user.name!)"
            
            self.screenName.text = "@\(user.screenname!)"
            
            if self.tweet != nil{
                self.tweetField.text = "@\(self.tweet!.user!.screenname!)"
                self.count = 140 - self.tweetField.text!.characters.count
                self.wordCount.text = String(self.count)
            }
            
            }) { (error: NSError) -> () in
        }

        }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tweetLengthChanged(sender: AnyObject) {
        print(69)
        self.wordCount.text = String(140 - self.tweetField.text!.characters.count)
        
       
    }
    
    
    @IBAction func postTweet(sender: AnyObject) {
        tweetField.resignFirstResponder()
        
        if(self.tweetField.text!.characters.count > 140){
           let invalidLengthAlert = UIAlertController(title: "Invalid Length", message: "Tweets can be a maximum of 140 characters!", preferredStyle: UIAlertControllerStyle.Alert)
        
            invalidLengthAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                
            }))
        
        }
        
        else{
        let address = "\(self.tweetField.text!)"
        let escapedAddress = address.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        if self.tweet != nil{
            TwitterClient.sharedInstance.reply(["tweet": escapedAddress!, "id": tweet!.ID!]) { (tweet, error) -> () in
                print("Tweeted")
            }
        }else{
            TwitterClient.sharedInstance.create(["tweet": escapedAddress!]) { (tweet, error) -> () in
                print("Tweeted")
            }
        }
        let successAlert = UIAlertController(title: "Successful Tweet", message: "Tweeted Successfully", preferredStyle: UIAlertControllerStyle.Alert)
        
        successAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            //If OK was clicked, present the original screen again
            self.bringOriginalScreen()
        }))
        
        self.presentViewController(successAlert, animated: true, completion: nil)
        }
    }
    
    func bringOriginalScreen(){
        navigationController?.popViewControllerAnimated(true)
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
