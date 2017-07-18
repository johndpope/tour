//
//  UINavigationBarBG.swift
//  Tour
//
//  Created by tnt on 5/30/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class UINavigationBarBG: UINavigationBar {

    override open class var layerClass: AnyClass {
        get{
            return CAGradientLayer.classForCoder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        let cgcolor1:CGColor = UIColor.init(hex: AColor.mainColorBackground1).cgColor
        let cgcolor2:CGColor = UIColor.init(hex: AColor.mainColorBackground2).cgColor
        gradientLayer.colors = [cgcolor1, cgcolor2]
    }
}