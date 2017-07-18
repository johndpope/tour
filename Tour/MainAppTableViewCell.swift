//
//  MainAppTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class MainAppTableViewCell: UITableViewCell {

    @IBOutlet weak var viewcontent: UIView!
    @IBOutlet weak var imagecompany: UIImageViewAvatar!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var totaltour: UILabel!
    @IBOutlet weak var namecompany: UILabel!
    @IBOutlet weak var taxcode: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!    
    @IBOutlet weak var sofax: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var fanpage: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var viewlike: GradientView!
    @IBOutlet weak var viewdetail: GradientView!
    @IBOutlet weak var viewdg: GradientView!
    @IBOutlet weak var viewshare: GradientView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var imagelike: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewcontent.layer.cornerRadius = 10
//        let shadowPath2 = UIBezierPath(rect: self.viewcontent.bounds)
        self.viewcontent.layer.masksToBounds = false
//        self.viewcontent.layer.shadowColor = UIColor.black.cgColor
//        self.viewcontent.layer.shadowOpacity = 0.5
//        self.viewcontent.layer.shadowPath = shadowPath2.cgPath
//        self.viewcontent.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
