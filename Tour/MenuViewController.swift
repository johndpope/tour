//
//  MenuViewController.swift
//  Tour
//
//  Created by tnt on 5/29/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Kingfisher
import PopupDialog
import Alamofire
import SwiftyJSON
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageavatar: UIImageViewAvatar!
    static var section1:[OutMenu] = [OutMenu]()
    static var section2:[OutMenu] = [OutMenu]()
    static var sectionsTitles:[String] = [String]()
    static var sectiondata:[Int:[OutMenu]] = [:]
    static var tbMenuView:UITableView = UITableView()
    @IBOutlet weak var viewHeaderMenu: UIView!
    @IBOutlet weak var tbMenuView: UITableView!
    @IBOutlet weak var viewInfoUser: UIView!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var imageAvatar: UIImageViewAvatar!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var permissionUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewHeaderNotLoggedData()
        checkLoggedInitViewHeader()
        self.registerDataSocketLocal(event: "logged", selector: #selector(loggedData))
    }
    
    func checkLoggedInitViewHeader(){
        if let user:User = self.getDataSocketLocal(event: "logged") as? User {
            print(user)
            initViewHeaderLoggedData()
            print("logged init header view");
        }
        else{
            print("not logged init header view");
            initViewHeaderNotLoggedData()
        }
    }
    
    func reloadDataMenuTableView(){
        MenuViewController.sectiondata = [0: MenuViewController.section1, 1:MenuViewController.section2]
        MenuViewController.tbMenuView.reloadData()
    }
    
    func initViewHeaderLoggedData(){
        viewInfoUser.isHidden = false
        viewheight.constant = 60
        let user:User = self.getDataSocketLocal(event: "logged") as! User
        let url  = URL(string :self.geturl(url: user._avatar))
        imageAvatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_vn"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        imageAvatar.layer.borderColor = UIColor.white.cgColor

        nameUser.text = user._detailname
//        permissionUser.text = user.getPermission()
        MenuViewController.section2 = [OutMenu(name: "Thiết lập",img: #imageLiteral(resourceName: "set")), OutMenu(name: "Đăng xuất",img: #imageLiteral(resourceName: "dangxuat"))]
        self.reloadDataMenuTableView()
    }
    func initViewHeaderNotLoggedData(){
        imageavatar.layer.borderColor = UIColor.white.cgColor
        MenuViewController.tbMenuView = self.tbMenuView
        MenuViewController.section1 = [OutMenu(name: "Quản lý tour",img: #imageLiteral(resourceName: "quan_ly_tour")), OutMenu(name: "EpacGroup",img: #imageLiteral(resourceName: "ic_searchtour")), OutMenu(name: "Tiện ích",img: #imageLiteral(resourceName: "ic_media"))]
        MenuViewController.section2 = [OutMenu(name: "Thiết lập",img: #imageLiteral(resourceName: "set")), OutMenu(name: "Đăng nhập",img: #imageLiteral(resourceName: "dangxuat")), OutMenu(name: "Đăng ký",img: #imageLiteral(resourceName: "dangxuat"))]
        MenuViewController.sectionsTitles = ["","Thông tin"]
        MenuViewController.sectiondata = [0: MenuViewController.section1, 1:MenuViewController.section2]
        viewheight.constant = 0
    }
    
    func loggedData() {
        viewInfoUser.isHidden = false
        viewheight.constant = 60
        let user:User = self.getDataSocketLocal(event: "logged") as! User
        let url  = URL(string :self.geturl(url: user._avatar))
        imageAvatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_vn"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        nameUser.text = user._detailname
//        permissionUser.text = user.getPermission()
        MenuViewController.section2 = [OutMenu(name: "Thiết lập",img: #imageLiteral(resourceName: "set")), OutMenu(name: "Đăng xuất",img: #imageLiteral(resourceName: "dangxuat"))]
        self.reloadDataMenuTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (MenuViewController.sectiondata[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("HeaderMenuViewCell", owner: self, options: nil)?.first as! HeaderMenuViewCell
        view.lblTitleMenu.text = MenuViewController.sectionsTitles[section]
        if(MenuViewController.sectionsTitles[section] != ""){
            view.layer.addBorder(edge: UIRectEdge.top, color: UIColor.darkGray, thickness: 0.5)
        }
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuViewController.sectionsTitles.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(MenuViewController.sectionsTitles[section] == ""){
            return 0
        }else{
            return 45
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.lblMenuName.text! = (MenuViewController.sectiondata[indexPath.section]?[indexPath.row])!._nameMenu
        cell.imgMenu.image = (MenuViewController.sectiondata[indexPath.section]?[indexPath.row])!._imgMenu
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        switch cell.lblMenuName.text! {
        case "EpacGroup":
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "MainAppViewController") as! MainAppViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            break
        case "Đăng nhập":
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            break
        case "Tiện ích":
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "UtilitiesViewController") as! UtilitiesViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            break
        case "Quản lý tour":
            if let _:User = self.getDataSocketLocal(event: "logged") as? User{
                let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryBoard.instantiateViewController(withIdentifier: "TourViewController") as! TourViewController
                let newFrontViewController = UINavigationController.init(rootViewController:desController)
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }else{
                self.alertLoginOrRegister()
            }
            break
        case "Đăng ký":
            let title = "Điều khoản sử dụng"
            let message = "Khi click đăng ký, bạn đã đồng ý với điều khoản của chúng tôi"
            let popup = PopupDialog(title: title, message: message)
            let buttonOne = DefaultButton(title: "Xem điều khoản") {
                let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryBoard.instantiateViewController(withIdentifier: "RulesViewController") as! RulesViewController
                let newFrontViewController = UINavigationController.init(rootViewController:desController)
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }
            let buttonTwo = DefaultButton(title: "Huỷ") {
                print("You canceled the car dialog.")
            }
            let buttonThree = DefaultButton(title: "Đồng ý", height: 60) {
                let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                let newFrontViewController = UINavigationController.init(rootViewController:desController)
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }
            popup.addButtons([buttonOne, buttonTwo, buttonThree])
            self.present(popup, animated: true, completion: nil)
            break
        case "Đăng xuất":
            self.logOut()
            break
        default:
            break
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func logOut(){
        let title = "ĐĂNG XUẤT"
        let message = "Bạn có chắc chắn muốn đăng xuất ???"
        let popup = PopupDialog(title: title, message: message, image: nil)
        let buttonOne = DefaultButton(title: "Đăng Xuất") {
            //print("You canceled the car dialog.")
            
            self.logoutAccount(GetDataFromURL.URL_LOGOUT)
            
        }
        let buttonTwo = CancelButton(title: "Huỷ") {
            //print("You canceled the car dialog.")
        }
        //popup.addButtons([buttonOne, buttonTwo, buttonThree])
        popup.addButtons([buttonOne,buttonTwo])
        popup.transitionStyle = .fadeIn
        popup.buttonAlignment = .horizontal
        self.present(popup, animated: true, completion: nil)
    }
    func logoutAccount(_ url:String){
        /*let parameters: Parameters! = [
         ]*/
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(url, method: .post/* parameters: parameters,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON( completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    print(json)
                    let code = json["code"].string! as String
                    if code == CodeServer.CODE_1000 || code == CodeServer.CODE_9998 {
                        MenuViewController.section2 = [OutMenu(name: "Thiết lập",img: #imageLiteral(resourceName: "set")), OutMenu(name: "Đăng nhập",img: #imageLiteral(resourceName: "dangxuat")), OutMenu(name: "Đăng ký",img: #imageLiteral(resourceName: "dangxuat"))]
                        MenuViewController.sectionsTitles = ["","Thông tin"]
                        MenuViewController.sectiondata = [0: MenuViewController.section1, 1:MenuViewController.section2]
                        self.viewheight.constant = 0
                        self.viewInfoUser.isHidden = true
                        MenuViewController.tbMenuView.reloadData()
                        
                        let revealViewController:SWRevealViewController = self.revealViewController()
                        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let desController = mainStoryBoard.instantiateViewController(withIdentifier: "MainAppViewController") as! MainAppViewController
                        let newFrontViewController = UINavigationController.init(rootViewController:desController)
                        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                        
                        UserDefaults.standard.removeObject(forKey: "checkRememberGlobal")
                        UserDefaults.standard.removeObject(forKey: "usernameRememberGlobal")
                        UserDefaults.standard.removeObject(forKey: "passwordRememberGlobal")
                        UserDefaults.standard.removeObject(forKey: StringUserdefaults.keyLoggedUserDefaultLocalSocket)
                        UserDefaults.standard.synchronize()
                        //                    SocketManager.closeConnection()
                    }
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        //TODO: Show Alert view on netwok connection.
                        self.popupWarningConnection()
                        //SVProgressHUD.dismiss()
                    }
                    break
                }
            })
    }
    
}
