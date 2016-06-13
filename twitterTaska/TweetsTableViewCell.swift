//
//  TweetsTableViewCell.swift
//  twitterTaska
//
//  Created by Maged Morkos on 6/13/16.
//  Copyright © 2016 Maged Morkos. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
