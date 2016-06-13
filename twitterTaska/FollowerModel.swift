//
//  FollowerModel.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/12/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import Foundation
import UIKit
import SwifteriOS

class FollowerModel : NSObject, NSCoding {
    
    var userId : String?
    var profileImageURL : String?
    var fullName : String?
    var screenName : String?
    var descriptn : String?
    var profileBackgroundImageUrl : String?
    
    init(followerObject: JSON){
        
        userId = followerObject["id_str"].string
        profileImageURL = followerObject["profile_image_url"].string
        fullName = followerObject["name"].string
        screenName = followerObject["screen_name"].string
        descriptn = followerObject["description"].string
        profileBackgroundImageUrl = followerObject["profile_background_image_url"].string
    }
    
    init(userId: String,
         profileImageURL: String,
         fullName: String,
         screenName: String,
         description: String, profileBackgroundImageUrl:String) {
        self.userId = userId
        self.profileImageURL = profileImageURL
        self.fullName = fullName
        self.screenName = screenName
        self.descriptn = description
        self.profileBackgroundImageUrl = profileBackgroundImageUrl
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let userId = decoder.decodeObjectForKey("userId") as? String,
            let profileImageURL = decoder.decodeObjectForKey("profileImageURL") as? String,
            let fullName = decoder.decodeObjectForKey("fullName") as? String,
            let screenName = decoder.decodeObjectForKey("screenName") as? String,
            let description = decoder.decodeObjectForKey("description") as? String,
            let profileBackgroundImageUrl = decoder.decodeObjectForKey("profileBackgroundImageUrl") as? String
            
            else { return nil }
        
        self.init(
            userId: userId,
            profileImageURL: profileImageURL,
            fullName: fullName,
            screenName: screenName,
            description: description, profileBackgroundImageUrl: profileBackgroundImageUrl
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.userId, forKey: "userId")
        coder.encodeObject(self.profileImageURL, forKey: "profileImageURL")
        coder.encodeObject(self.fullName, forKey: "fullName")
        coder.encodeObject(self.screenName, forKey: "screenName")
        coder.encodeObject(self.descriptn, forKey: "description")
    }
    
}