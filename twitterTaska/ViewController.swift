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
        self.swifter = Swifter(consumerKey: "Eex0sdHRO5ZYB5BxaUTbYhNoH", consumerSecret: "ugtAjpDOvoDWZG51EsyKC6Q4Z0Uyioc182PijiHmPf6WnwEzLn")
        
        
        
        let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let accessTokenSecret = userDefault.objectForKey("accessTokenSecret") as? String {
            if let accessTokenKey = userDefault.objectForKey("accessTokenKey") as? String {
                self.swifter = Swifter(consumerKey: "Eex0sdHRO5ZYB5BxaUTbYhNoH", consumerSecret: "ugtAjpDOvoDWZG51EsyKC6Q4Z0Uyioc182PijiHmPf6WnwEzLn", oauthToken: accessTokenKey, oauthTokenSecret: accessTokenSecret)
                fetchTwitterHomeStream()
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
            userDefult.synchronize()
            
            }, failure: failureHandler)
        
    }
    
    
    func fetchTwitterHomeStream() {
        let failureHandler: ((NSError) -> Void) = { error in
            Global().alertWithTitle("Error", message: error.localizedDescription, viewController: self)
        }
        
        self.swifter!.getStatusesHomeTimelineWithCount(20, success: { statuses in
            
            // Successfully fetched timeline, so lets create and push the table view
//            let tweetsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
            guard let tweets = statuses else { return }
            
            print(tweets)
            
//            tweetsViewController.tweets = tweets
//            self.navigationController?.pushViewController(tweetsViewController, animated: true)
            //                self.presentViewController(tweetsViewController, animated: true, completion: nil)
            
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

