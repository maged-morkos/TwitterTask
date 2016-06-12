//
//  FollowerCell.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/12/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import UIKit

class FollowerCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
