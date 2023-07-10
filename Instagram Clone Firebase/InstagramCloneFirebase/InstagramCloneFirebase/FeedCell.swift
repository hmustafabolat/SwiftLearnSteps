//
//  FeedCell.swift
//  InstagramCloneFirebase
//
//  Created by Musti on 10.07.2023.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func likeButtonClicked(_ sender: Any) {
    }
    
    

}
