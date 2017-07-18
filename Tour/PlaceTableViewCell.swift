//
//  PlaceTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/27/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var slideShow: UIScrollView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var nameplace: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var viewcontent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initlayer(v: viewcontent)
    }
    
}
