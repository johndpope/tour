//
//  Utilities.swift
//  Tour
//
//  Created by tnt on 6/2/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
class Utilities{
    private var image:UIImage
    private var label:String
    private var link:String
    
    var _image:UIImage! {
        get{
            return self.image
        }
        set(value){
            self.image = value
        }
    }
    var _label:String! {
        get {
            return self.label
        }
        set(value){
            self.label = value
        }
    }
    var _link:String! {
        get {
            return self.link
        }
        set(value){
            self.link = value
        }
    }
    init() {
        self.link = ""
        self.image = UIImage()
        self.label = ""
    }
    init(link:String, image:UIImage, label:String) {
        self.link = link
        self.image = image
        self.label = label
    }
}
