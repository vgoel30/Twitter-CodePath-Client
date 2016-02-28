//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Varun Goel on 2/26/16.
//  Copyright © 2016 Varun Goel. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
 
    
    @IBOutlet var tweetTable: UITableView!
   
   
    //the array of tweets
    var tweets:[Tweet]?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tweetTable.insertSubview(refreshControl, atIndex: 0)
        
    
        tweetTable.dataSource = self
        tweetTable.delegate = self
        tweetTable.rowHeight = UITableViewAutomaticDimension
        tweetTable.estimatedRowHeight = 120
        
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets as [Tweet]!
            self.tweetTable.reloadData()
          
            

            }, failure:  { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil{
            print(tweets!.count)
            return tweets!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetTable.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets as [Tweet]!
            self.tweetTable.reloadData()
            
            refreshControl.endRefreshing()
            
            
            }, failure:  { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //variable to keep track of if more data is being loaded
    var isMoreDataLoading = false
    
    
    //check if the scrolling is taking place
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tweetTable.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tweetTable.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tweetTable.dragging) {
                isMoreDataLoading = true
                loadMoreData()
            }
            
        }
    }
    
    //function that loads more data once the bottom screen has been reached.
    func loadMoreData() {
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets! += tweets
            self.tweetTable.reloadData()
            self.isMoreDataLoading = false
            
            
            }, failure:  { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }
    
   
    //when the logout button is clicked
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
   
    
    
    //function to check if internet connection is active or not
    
    
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
