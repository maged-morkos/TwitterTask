//
//  FollowerDetailsViewController.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/13/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import UIKit
import SwifteriOS
class FollowerDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mbTableView : MBTwitterScroll?
    var cellHight : CGFloat = 0
    var currentUser : FollowerModel?
    var backgroundImage : UIImage?
    var profileImage : UIImage?
    
    var swifter: Swifter?
    var userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var tweetsArray = [JSON]()
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getTweetsForCurrentUser()
    }
    func getTweetsForCurrentUser() {
        
        let status = Reach().connectionStatus()
        
        
        switch status {
        case .Unknown, .Offline:
            
            Global().alertWithTitle("No internet", message: "Connect and try again", viewController: self)
            break
        case .Online(.WWAN), .Online(.WiFi):
            fetchTweetsList()
            break
        }
    }
    func fetchTweetsList() {
        
        let failureHandler: ((NSError) -> Void) = { error in
            Global().alertWithTitle("Error", message: error.localizedDescription, viewController: self)
        }
        
        if let accessTokenSecret = userDefault.objectForKey("accessTokenSecret") as? String {
            if let accessTokenKey = userDefault.objectForKey("accessTokenKey") as? String {
                self.swifter = Swifter(consumerKey: Global.twitterKeys.consumerKey, consumerSecret: Global.twitterKeys.secretKey, oauthToken: accessTokenKey, oauthTokenSecret: accessTokenSecret)
                self.swifter?.getStatusesUserTimelineWithUserID((currentUser?.userId)!,success: { tweetsList in
                    guard let tweets = tweetsList else { return }
                    self.tweetsArray = tweets
                    self.setView()
                    }, failure: failureHandler)
            }
        }
        
    }
    func setView() {
        if currentUser?.profileBackgroundImageUrl != nil {
            
            let backgroundImageDate = NSData(contentsOfURL: NSURL(string: (currentUser?.profileBackgroundImageUrl)!)!)
            backgroundImage = UIImage(data: backgroundImageDate!)
            
        }
        else{
            backgroundImage = UIImage(named: "header_bg")
        }
        if let profileImageData =  NSData(contentsOfURL: NSURL(string: (currentUser?.profileImageURL)!)!){
            
            profileImage = UIImage(data: profileImageData)
        }else{
            profileImage = UIImage(named: "profile")
        }
        
        mbTableView = MBTwitterScroll(tableViewWithBackgound: backgroundImage, avatarImage: profileImage, titleString: currentUser?.fullName, subtitleString: currentUser?.screenName, buttonTitle: "")
        mbTableView?.tableView.delegate = self
        mbTableView?.tableView.dataSource = self
        
        self.view.addSubview(mbTableView!)
        
        
        mbTableView?.tableView.registerNib(UINib(nibName: "TweetsTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        
        self.view.bringSubviewToFront(self.backButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TweetsTableViewCell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetsTableViewCell
        cell.tweetTextView.text = self.tweetsArray[indexPath.row]["text"].string
        cell.translatesAutoresizingMaskIntoConstraints = true
        cell.tweetTextView.sizeToFit()
        cellHight = cell.tweetTextView.frame.origin.y + cell.tweetTextView.frame.size.height
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHight
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
