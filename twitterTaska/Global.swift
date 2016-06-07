//
//  Global.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/7/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import UIKit

class Global {
    
    func alertWithTitle(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}
