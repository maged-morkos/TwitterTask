//
//  ViewController.swift
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

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var swifter: Swifter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swifter = Swifter(consumerKey: Global.twitterKeys.consumerKey, consumerSecret: Global.twitterKeys.secretKey)
        
        
        
        let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let accessTokenSecret = userDefault.objectForKey("accessTokenSecret") as? String {
            if let accessTokenKey = userDefault.objectForKey("accessTokenKey") as? String {
                self.swifter = Swifter(consumerKey: Global.twitterKeys.consumerKey, consumerSecret: Global.twitterKeys.secretKey, oauthToken: accessTokenKey, oauthTokenSecret: accessTokenSecret)
                
            }
        }
    }
    
    
    
    @IBAction func loginWithTwitterAction(sender: AnyObject) {
        
        let failureHandler: ((NSError) -> Void) = { error in
            
            Global().alertWithTitle("Error", message: error.localizedDescription, viewController: self)
        }
        
        let url = NSURL(string: "TwitterTaska://success")!
        
        swifter?.authorizeWithCallbackURL(url, presentFromViewController: self, success: { (accessToken, response) in
            accessToken
            
            let userDefult : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            userDefult.setObject(accessToken?.secret, forKey: "accessTokenSecret")
            userDefult.setObject(accessToken?.key, forKey: "accessTokenKey")
            userDefult.setObject(accessToken?.screenName!, forKey: "screenName")
            userDefult.setObject(accessToken?.userID!, forKey: "userID")
            userDefult.synchronize()
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let followersViewController:FollowersViewController = mainStoryboard.instantiateViewControllerWithIdentifier("FollowersViewController") as! FollowersViewController
            
            let nav = UINavigationController(rootViewController: followersViewController)
            
            self.presentViewController(nav, animated: true, completion: nil)
            
            }, failure: failureHandler)
        
    }
    
    
    
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

