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
    var screenName : String?
    var userID : String?
    var followersListArray : [JSONValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let accessTokenSecret = userDefault.objectForKey("accessTokenSecret") as? String {
            if let accessTokenKey = userDefault.objectForKey("accessTokenKey") as? String {
                self.swifter = Swifter(consumerKey: "Eex0sdHRO5ZYB5BxaUTbYhNoH", consumerSecret: "ugtAjpDOvoDWZG51EsyKC6Q4Z0Uyioc182PijiHmPf6WnwEzLn", oauthToken: accessTokenKey, oauthTokenSecret: accessTokenSecret)
                
                userID = userDefault.objectForKey("userID") as? String
                screenName = userDefault.objectForKey("screenName") as? String
                
                fetchFollowersList()
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
            
            self.followersListArray = followersList.users!
            self.tableView.reloadData()
            }, failure: failureHandler)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followersListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.followersListArray[indexPath.row]["name"].string
        
        return cell
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
