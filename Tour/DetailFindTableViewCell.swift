//
//  DetailFindTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/11/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class DetailFindTableViewCell: UITableViewCell {

    @IBOutlet weak var slideShow: UIScrollView!
    @IBOutlet weak var nametour: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var timestart: UILabel!
    @IBOutlet weak var seal: UILabel!
    @IBOutlet weak var countdown: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pricediscount: UILabel!
    @IBOutlet weak var viewcontent: UIView!
    
    @IBOutlet weak var btnDetailInfo: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
