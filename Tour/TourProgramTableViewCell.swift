//
//  TourProgramTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/21/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class TourProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingWebView: UIActivityIndicatorView!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var imagebtntourprogram: UIImageView!
    
    @IBOutlet weak var webViewTourProgram: UIWebView!
    
    @IBOutlet weak var heightWebView: NSLayoutConstraint!
       
    @IBOutlet weak var btnShowTourProgram: GradientViewButton!
    
    @IBOutlet weak var viewcontent: UIView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        initlayer(v: viewcontent)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
