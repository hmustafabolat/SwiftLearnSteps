//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Musti on 26.07.2023.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var feedUserNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
