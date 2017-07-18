//
//  HATableViewCell.swift
//  Tour
//
//  Created by tnt on 7/8/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class HATableViewCell: UITableViewCell {

    @IBOutlet weak var viewcontent: UIView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var slideShow: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
