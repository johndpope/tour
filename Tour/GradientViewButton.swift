//
//  GradientViewButton.swift
//  Tour
//
//  Created by tnt on 6/2/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//
import UIKit

class GradientViewButton: UIView {
    
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
        let cgcolor1:CGColor = UIColor.init(hex: AColor.buttonColorBackground1).cgColor
        let cgcolor2:CGColor = UIColor.init(hex: AColor.buttonColorBackground2).cgColor
        gradientLayer.colors = [cgcolor1, cgcolor2]
        
        gradientLayer.cornerRadius = 5
        gradientLayer.masksToBounds = false
        gradientLayer.shadowColor = UIColor.black.cgColor
        gradientLayer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        gradientLayer.shadowOpacity = 0.4
        gradientLayer.borderWidth = 2
        gradientLayer.borderColor = UIColor.init(hex:AColor.mainColorBackground1).cgColor
    }
    
}
