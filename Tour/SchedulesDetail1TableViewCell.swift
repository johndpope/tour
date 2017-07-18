//
//  SchedulesDetail1TableViewCell.swift
//  Tour
//
//  Created by tnt on 7/6/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class SchedulesDetail1TableViewCell: UITableViewCell {

    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var heightTableViewPlace: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewPlace: UITableView!
    
    @IBOutlet weak var contentview: UIView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var event: UILabel!
    
    var listPlace:[Place] = [Place]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initlayer(v: contentview)
    }
    
}

