//
//  UIImageViewAvatar.swift
//  Tour
//
//  Created by tnt on 5/30/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class UIImageViewAvatar: UIImageView {

    override open class var layerClass: AnyClass {
        get{
            return CAGradientLayer.classForCoder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = UIColor(hex: AColor.borderavatargreen).cgColor
        self.layer.borderWidth = 2.0
        self.clipsToBounds = true
    }

}
