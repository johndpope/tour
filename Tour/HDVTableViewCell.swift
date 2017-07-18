//
//  HDVTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/25/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class HDVTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageViewAvatar!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var numberphone: UILabel!
    @IBOutlet weak var addresslocation: UILabel!
    @IBOutlet weak var messageonoff: UIImageView!
    @IBOutlet weak var btnMessage: UIView!
    @IBOutlet weak var btnCall: UIView!
    @IBOutlet weak var viewcontent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func draw(_ rect: CGRect) {
        initlayer(v: viewcontent)
    }
    
}
