//
//  BodyInfoPriceTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/25/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class BodyInfoPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pricediscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
