//
//  LoginViewController.swift
//  Tour
//
//  Created by tnt on 5/29/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import SVProgressHUD
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
class LoginViewController: UIViewController {

    @IBOutlet weak var btnShowAndHideMenu: UIBarButtonItem!
    @IBOutlet weak var txtUsername: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var checkRemember: CheckBox!
    
    var user:User = User()
    
    @IBAction func btnLogin(_ sender: Any) {
        let txtUsername = self.txtUsername.text
        let txtPassword = self.txtPassword.text
        if txtUsername == "" {
            self.alert(message: "Bạn Chưa Nhập Tên Đăng Nhập ")
        }
        else if txtPassword == "" {
            self.alert(message: "Bạn Chưa Nhập Mật Khẩu")
        }
        else{
            SVProgressHUD.show(withStatus: "Đang Đăng Nhập ...")
            self.getLoginData(GetDataFromURL.URL_LOGIN, username: txtUsername!, password: txtPassword!, completion: {_ in
                SVProgressHUD.dismiss()
                if self.user._lock == 1 {
                    self.alert(message: "Tài Khoản Của Bạn Đã Bị Khoá")
                }
                else{
                    self.emitDataSocketLocal(event: "logged", data: self.user)
                    if self.checkRemember.isChecked == true {
                        print("Check")
                        UserDefaults.standard.set(1, forKey: StringUserdefaults.checkRememberGlobal)
                        UserDefaults.standard.setValue(txtUsername, forKey: StringUserdefaults.usernameRememberGlobal)
                        UserDefaults.standard.setValue(txtPassword, forKey: StringUserdefaults.passwordRememberGlobal)
                    }
                    else{
                        print("Uncheck")
                        UserDefaults.standard.set(0, forKey: "checkRememberGlobal")
                    }
                    let revealViewController:SWRevealViewController = self.revealViewController()
                    let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let desController = mainStoryBoard.instantiateViewController(withIdentifier: "MainAppViewController") as! MainAppViewController
                    let newFrontViewController = UINavigationController.init(rootViewController:desController)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func layout() {
        self.layoutButtonNav(btnShowAndHideMenu: btnShowAndHideMenu)
        layoutTextField();
    }
    
    func layoutTextField(){
        UITextField.connectFields(fields: [txtUsername, txtPassword])
        let colorA = UIColor(hex: AColor.blackColor)
        let colorB = UIColor(hex : AColor.mainColor)
        
        txtUsername.placeholder = "Nhập tên đăng nhập "
        txtUsername.title = "Tên Đăng Nhập"
        txtUsername.iconFont = UIFont(name: "FontAwesome", size: 15)
        /*let myChar: UniChar = 0xf007
         txtHoTen.iconText = String(format: "%C", myChar)*/
        txtUsername.iconText = "\u{f007}"
        txtUsername.selectedIconColor = colorB
        txtUsername.tintColor = colorA
        txtUsername.titleColor = colorB
        txtUsername.selectedTitleColor = colorB
        txtUsername.selectedLineColor = colorB
        
        txtPassword.placeholder = "Nhập mật khẩu"
        txtPassword.title = "Mật Khẩu"
        txtPassword.iconFont = UIFont(name: "FontAwesome", size: 15)
        /*let myChar: UniChar = 0xf007
         txtHoTen.iconText = String(format: "%C", myChar)*/
        txtPassword.iconText = "\u{f023}"
        txtPassword.selectedIconColor = colorB
        txtPassword.tintColor = colorA
        txtPassword.titleColor = colorB
        txtPassword.selectedTitleColor = colorB
        txtPassword.selectedLineColor = colorB
        txtPassword.isSecureTextEntry = true
    }

    func getLoginData(_ url:String,username:String,password:String, completion: @escaping (Bool) -> Void){
        let parameters: Parameters! = [
            "username":username,
            "password":password
        ]
//        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    self.parseDataLogin(response.data!)
                    completion(true)
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        //TODO: Show Alert view on netwok connection.
                        self.popupWarningConnection()
                        SVProgressHUD.dismiss()
                    }
                    completion(true)
                    break
                }
            })
    }
    func parseDataLogin(_ JSONData : Data){
        do{
            let json = JSON(data:JSONData)
            let code = json["code"].string! as String
            if code == CodeServer.CODE_1000 {
                user = User.parseJson(userjson: json["data"])
            }
            else if code == CodeServer.CODE_1003 {
                self.alert(message: "Sai Tên Đăng Nhập Hoặc Mật Khẩu")
            }
            else {
                let message = checkCode(code: code)
                self.alert(message: message)
            }
        }
    }


}
