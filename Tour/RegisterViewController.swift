//
//  RegisterViewController.swift
//  Tour
//
//  Created by tnt on 6/4/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var btnShowAndHideMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutButtonNav(btnShowAndHideMenu: btnShowAndHideMenu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
