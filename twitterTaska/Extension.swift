//
//  UIImageViewExt.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/12/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(link link:String, contentMode: UIViewContentMode) {
        NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}