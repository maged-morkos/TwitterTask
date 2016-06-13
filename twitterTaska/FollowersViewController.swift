//
//  FollowersViewController.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/7/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import UIKit
import Accounts
import Social
import SwifteriOS
import SafariServices

class FollowersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var swifter: Swifter?
    var userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var screenName : String?
    var userID : String?
    var followersListArray : [FollowerModel] = []
    var cellHight : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getFollowersList()
    }
    
    func getFollowersList() {
        
        if let accessTokenSecret = userDefault.objectForKey("accessTokenSecret") as? String {
            if let accessTokenKey = userDefault.objectForKey("accessTokenKey") as? String {
                self.swifter = Swifter(consumerKey: Global.twitterKeys.consumerKey, consumerSecret: Global.twitterKeys.secretKey, oauthToken: accessTokenKey, oauthTokenSecret: accessTokenSecret)
                
                userID = userDefault.objectForKey("userID") as? String
                screenName = userDefault.objectForKey("screenName") as? String
                
                let status = Reach().connectionStatus()
                
                
                switch status {
                case .Unknown, .Offline:
                    if  self.userDefault.objectForKey("FollowersList") != nil {
                        if let data = self.userDefault.objectForKey("FollowersList") as? NSData {
                            self.followersListArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [FollowerModel]
                            self.tableView.reloadData()
                        }
                    }else{
                        Global().alertWithTitle("No internet", message: "Connect and try again", viewController: self)
                    }
                    break
                case .Online(.WWAN), .Online(.WiFi):
                    fetchFollowersList()
                    break
                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func fetchFollowersList() {
        
        let failureHandler: ((NSError) -> Void) = { error in
            Global().alertWithTitle("Error", message: error.localizedDescription, viewController: self)
        }
        
        self.swifter?.getFollowersListWithID(userID!,success: { followersList in
            
            let followersArray = followersList.users!
            print(followersArray)
            for currentUserDic in followersArray {
                
                self.followersListArray.append(FollowerModel(followerObject: currentUserDic))
                
            }
            let data = NSKeyedArchiver.archivedDataWithRootObject(self.followersListArray)
            self.userDefault.setObject(data, forKey: "FollowersList")

            self.tableView.reloadData()
            }, failure: failureHandler)
        
    }
    // MARK TableView Delegate and DateSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followersListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FollowerCell = self.tableView.dequeueReusableCellWithIdentifier("FollowerCell")! as! FollowerCell
        cell.fullNameLabel.text = self.followersListArray[indexPath.row].fullName
        cell.screenNameLabel.text = self.followersListArray[indexPath.row].screenName
        cell.descriptionTextView.text = self.followersListArray[indexPath.row].descriptn
        cell.descriptionTextView.sizeToFit()
        cell.profileImageView.downloadImageFrom(link:
            self.followersListArray[indexPath.row].profileImageURL!, contentMode: UIViewContentMode.ScaleAspectFit)
        
        cellHight = cell.descriptionTextView.frame.origin.y + cell.descriptionTextView.frame.size.height
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let followerDetails:FollowerDetailsViewController = mainStoryboard.instantiateViewControllerWithIdentifier("FollowerDetailsViewController") as! FollowerDetailsViewController
        
        
        
        followerDetails.currentUser = self.followersListArray[indexPath.row]
        self.navigationController?.pushViewController(followerDetails, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
