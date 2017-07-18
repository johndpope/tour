//
//  DVKTCollectionViewCell.swift
//  Tour
//
//  Created by tnt on 6/23/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class DVKTCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var viewcontent: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    override func draw(_ rect: CGRect) {
        initlayer(v: viewcontent)
    }
}
