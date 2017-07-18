//
//  AssignmentTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/17/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Cosmos
class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var avatar: UIImageViewAvatar!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numstart: CosmosView!
    @IBOutlet weak var isattent: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var ic_shield: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
