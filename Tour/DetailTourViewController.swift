//
//  DetailTourViewController.swift
//  Tour
//
//  Created by tnt on 7/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailTourViewController: UIViewController, UISearchBarDelegate {
    
    var tourRec:Tour!
    @IBOutlet weak var btnShowFragmentInfo: UIView!
    @IBOutlet weak var btnShowFragmentMap: UIView!
    @IBOutlet weak var fragmentContent: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewSearchBar: UIView!
    
    var isHiddenViewTitle:Bool = true
    var index:Int = -1
    var fragment:UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initFragment(index: 0)
        initButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.emitDataSocketLocal(event: StringUserdefaults.textSearchUseroftour, data: searchText as AnyObject)
    }
    
    @IBAction func btnMail(_ sender: UIButton) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Nội dung phản hồi", message: nil, preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Vui lòng nhập"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { [weak alert] (_) in
            
        }))
        alert.addAction(UIAlertAction(title: "Gửi", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            let stringreport = textField.text!
            if stringreport == "" {
                self.alert(message: "Vui lòng nhập dữ liệu trước khi gửi")
                return
            }
            self.mailReport(stringreport: stringreport)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func mailReport(stringreport:String){
        guard let user = self.getDataSocketLocal(event: "logged") as? User else {
            return
        }
        let parameters: Parameters! = [
            "idtour":tourRec._idtour,
            "usersender": user._username,
            "to": tourRec._user._username,
            "content": stringreport,
            "createat": Date().millisecondsSince1970
        ]
//        print(parameters)
        Alamofire.request(GetDataFromURL.URL_PUSH_REPORT, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    let code = json["code"].string! as String
                    if code == CodeServer.CODE_1000 {
                       self.alert(message: "Gửi phản hồi thành công")
                    }else{
                        self.alert(message: "Lổi gửi phản hồi")
                    }
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        print("error in appdelegate")
                    }
                    break
                }
            })
        
        
        
    }
    @IBAction func btnSearch(_ sender: UIBarButtonItem) {
        if isHiddenViewTitle == true {
            UIView.transition(with: self.viewTitle, duration: 0.2, options: .transitionFlipFromTop, animations: { _ in
                self.viewTitle.isHidden = true
            }, completion: nil)
            UIView.transition(with: self.viewSearchBar, duration: 0.2, options: .transitionFlipFromTop, animations: { _ in
                self.viewSearchBar.isHidden = false
            }, completion: nil)
            
        }else{
            UIView.transition(with: self.viewTitle, duration: 0.2, options: .transitionFlipFromBottom, animations: { _ in
                self.viewTitle.isHidden = false
            }, completion: nil)
            UIView.transition(with: self.viewSearchBar, duration: 0.2, options: .transitionFlipFromBottom, animations: { _ in
                self.viewSearchBar.isHidden = true
            }, completion: nil)
        }
        isHiddenViewTitle = !isHiddenViewTitle
    }
    
    func initFragment(index:Int){
        if self.index != index{
            self.index = index
            for subview in fragmentContent.subviews{
                subview.removeFromSuperview()
            }
            switch index {
            case 0:
                let fragmentInfo = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailTourInfoViewController") as! DetailTourInfoViewController
                fragmentInfo.tourRec = self.tourRec
                self.addChildViewController(fragmentInfo)
                fragmentContent.bounds = fragmentInfo.view.bounds
                self.fragmentContent.addSubview(fragmentInfo.view)
                fragmentInfo.didMove(toParentViewController: self)
                break
            case 1:
                let fragmentMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                fragmentMap.tourRec = self.tourRec
                fragmentMap.frameMapView = fragmentContent.frame
                self.addChildViewController(fragmentMap)
                //                fragmentContent.bounds = fragmentMap.view.bounds
//                fragmentMap.view.bounds = fragmentContent.bounds
                
                self.fragmentContent.addSubview(fragmentMap.view)
               
                fragmentMap.didMove(toParentViewController: self)
                break
            default:
                break
            }
        }
    }
    func initButton(){
        let tapInfo = UITapGestureRecognizer(target: self, action: #selector(self.btnShowFragmentInfo(_:)))
        self.btnShowFragmentInfo.isUserInteractionEnabled = true
        self.btnShowFragmentInfo.addGestureRecognizer(tapInfo)
        
        let tapMap = UITapGestureRecognizer(target: self, action: #selector(self.btnShowFragmentMap(_:)))
        self.btnShowFragmentMap.isUserInteractionEnabled = true
        self.btnShowFragmentMap.addGestureRecognizer(tapMap)
    }
    func btnShowFragmentInfo(_ sender:UIGestureRecognizer){
        initFragment(index: 0)
    }
    func btnShowFragmentMap(_ sender:UIGestureRecognizer){
        initFragment(index: 1)
    }

}
