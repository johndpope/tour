//
//  SPlashViewController.swift
//  Tour
//
//  Created by tnt on 6/5/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PopupDialog
class SPlashViewController: UIViewController{

    @IBOutlet weak var splashloading: UIActivityIndicatorView!
    var user:User = User()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashloading.hidesWhenStopped = true
        splashloading.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        splashloading.stopAnimating()
        if let ischeck = UserDefaults.standard.object(forKey: StringUserdefaults.checkRememberGlobal) as? Int{
            if ischeck == 0 {
                UserDefaults.standard.removeObject(forKey: "checkRememberGlobal")
                UserDefaults.standard.removeObject(forKey: "usernameRememberGlobal")
                UserDefaults.standard.removeObject(forKey: "passwordRememberGlobal")
                UserDefaults.standard.removeObject(forKey: StringUserdefaults.keyLoggedUserDefaultLocalSocket)
                self.performSegue(withIdentifier: "gotoMainApp", sender: nil)
            }else{
                print("remember")
                let username = UserDefaults.standard.object(forKey: StringUserdefaults.usernameRememberGlobal) as! String
                let password = UserDefaults.standard.object(forKey: StringUserdefaults.passwordRememberGlobal) as! String
                
                self.getLoginData(GetDataFromURL.URL_LOGIN, username: username, password: password, completion: {_ in
                    if self.user._lock == 1 {
                        self.alert(message: "Tài Khoản Của Bạn Đã Bị Khoá")
                        self.performSegue(withIdentifier: "gotoMainApp", sender: nil)
                    }
                    else{
                        self.performSegue(withIdentifier: "gotoMainApp", sender: nil)
                    }
                })
                
            }
        }else{
            print("not exist login before")
            self.performSegue(withIdentifier: "gotoMainApp", sender: nil)
        }
    }
    
    func getLoginData(_ url:String,username:String,password:String, completion: @escaping (Bool) -> Void){
        let parameters: Parameters! = [
            "username":username,
            "password":password
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
//                    let json = JSON(data:response.data!)
//                    print(json)
                    self.parseDataLogin(response.data!)
                    completion(true)
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        //TODO: Show Alert view on netwok connection.
                        self.popupWarningConnection()
                    }
                    completion(true)
                    break
                }
            })
    }
    func parseDataLogin(_ JSONData : Data){
        do{
            let json = JSON(data:JSONData)
//            print(json)
            let code = json["code"].string! as String
            if code == CodeServer.CODE_1000 {
                user = User.parseJson(userjson: json["data"])
                self.emitDataSocketLocal(event: "logged", data: self.user)
            }
            else {
                self.performSegue(withIdentifier: "gotoMainApp", sender: nil)
            }
        }
    }
}
