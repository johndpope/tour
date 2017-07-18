//
//  OutMenu.swift
//  Tour
//
//  Created by tnt on 5/30/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation	
class OutMenu{
    private var nameMenu:String!
    private var imgMenu:UIImage!
    var _nameMenu : String! {
        get{
            return self.nameMenu
        }
        set(value) {
            self.nameMenu = value
        }
    }
    var _imgMenu : UIImage! {
        get{
            return self.imgMenu
        }
        set(value) {
            self.imgMenu = value
        }
    }
    init() {
        self.nameMenu = ""
        self.imgMenu = UIImage()
    }
    init(name:String, img:UIImage) {
        self.nameMenu = name
        self.imgMenu = img
    }
}
