//
//  TimelineViewCell.swift
//  Onliner
//
//  Created by 伊藤　陽香 on 2020/10/14.
//  Copyright © 2020 伊藤　陽香. All rights reserved.
//

import UIKit
import Firebase

class TimelineViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchDownLikeButton() {
        
        likeButton.setImage(UIImage(named: "heartdone"), for: .normal)
        
    }
    
    
}
