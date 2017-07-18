//
//  MenuTableViewCell.swift
//  Tour
//
//  Created by tnt on 5/29/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
