//
//  MainAppViewController.swift
//  Tour
//
//  Created by tnt on 5/29/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Kingfisher

class MainAppViewController: UIViewController, UITabBarDelegate {
    
    var index:Int = -1
    @IBOutlet weak var btnShowAndHideMenu: UIBarButtonItem!
    @IBOutlet weak var fragment: UIView!
    var userSend:User!
    @IBOutlet weak var btnHome: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutButtonNav(btnShowAndHideMenu: btnShowAndHideMenu)
        getUserTour { (user) in
            self.userSend = user
            self.initFragment(index: 0)
        }
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if userSend != nil {
            initFragment(index: item.tag)
        }else{
            self.alert(message: "Lổi chưa lấy được dữ liệu vui lòng thử lại sau")
        }
    }
    func getUserTour(completion: @escaping (_ user:User) ->() ){
        var parameters: Parameters!
        
        if let user = self.getDataSocketLocal(event: "logged") as? User{
            parameters = [
                "iduser":"",
                "idusercompany": 4,
                "lat":user._lat,
                "lng":user._lng
            ]
        }else{
            parameters = [
                "iduser":"",
                "idusercompany": 4,
                "lat":UserDefaults.standard.double(forKey: StringUserdefaults.latNotLogin),
                "lng":UserDefaults.standard.double(forKey: StringUserdefaults.lngNotLogin)
            ]
        }
        
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_GET_USER_EPAC, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    let code = json["code"].string! as String
                    if code == CodeServer.CODE_1000 {
                        let data = json["data"]
                        let item = data["items"][0]
                        let u:User = User.parseJson(userjson: item)
                        completion(u)
                    }else{
                        self.alert(message: "Lổi truy cập dữ liệu, Vui lòng trở lại sau")
                    }
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        //TODO: Show Alert view on netwok connection.
                        self.popupWarningConnection()
                        
                    }
                    break
                }
                SVProgressHUD.dismiss()
            })
    }
    
    func initFragment(index:Int){
        if self.index != index{
            self.index = index
            for subview in fragment.subviews{
                subview.removeFromSuperview()
            }
            switch index {
            case 0:
                let fragmentSub = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GTViewController") as! GTViewController
                fragmentSub.userRec = self.userSend
                self.addChildViewController(fragmentSub)
                fragment.bounds = fragmentSub.view.bounds
                self.fragment.addSubview(fragmentSub.view)
                fragmentSub.didMove(toParentViewController: self)
                break
            case 1:
                let fragmentSub = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailFindTourViewController") as! DetailFindTourViewController
                fragmentSub.userRec = self.userSend
                self.addChildViewController(fragmentSub)
                fragment.bounds = fragmentSub.view.bounds
                self.fragment.addSubview(fragmentSub.view)
                fragmentSub.didMove(toParentViewController: self)
                break
            case 2:
                let fragmentSub = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HAViewController") as! HAViewController
                fragmentSub.userRec = self.userSend
                self.addChildViewController(fragmentSub)
                fragment.bounds = fragmentSub.view.bounds
                self.fragment.addSubview(fragmentSub.view)
                fragmentSub.didMove(toParentViewController: self)
                break
            case 3:
                let fragmentSub = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SPViewController") as! SPViewController
                fragmentSub.userRec = self.userSend
                self.addChildViewController(fragmentSub)
                fragment.bounds = fragmentSub.view.bounds
                self.fragment.addSubview(fragmentSub.view)
                fragmentSub.didMove(toParentViewController: self)
                
                break
            default:
                break
            }
        }
    }
}
