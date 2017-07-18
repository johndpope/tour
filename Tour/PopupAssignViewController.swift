//
//  PopupAssignViewController.swift
//  Tour
//
//  Created by tnt on 6/17/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON
import SVProgressHUD
class PopupAssignViewController: UIViewController {

    
    @IBOutlet weak var ratingNumber: CosmosView!
    @IBOutlet weak var btnSendAssign: GradientView!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var viewContent: UIView!
    
    var user:User!
    var userCompany:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        user = self.getDataSocketLocal(event: "logged") as! User as User
        showAnimate()
        getCheckAssignment()
    }
    
    func getCheckAssignment() {
        let parameters: Parameters! = [
            "useriduser":user._iduser,
            "useridcompany":userCompany._iduser
        ]
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_GET_ASSIGNMENT_CHECK, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
//                    print(json)
                    self.processResponseNumstart(json: json)
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        self.popupWarningConnection()
                    }
                    break
                }
                SVProgressHUD.dismiss()
            })
    }
    func processResponseNumstart(json:JSON){
        let code = json["code"].string! as String
        switch code {
        case CodeServer.CODE_1000:
            let data = json["data"]
            initNumberStart(data: data["items"][0])
            break
        default:
            break
        }
    }
    
    func initNumberStart(data:JSON){
        let numberStart:Int = data["maxstart"].int!
        if numberStart > 0 {
            ratingNumber.rating = Double(numberStart)
            ratingNumber.settings.updateOnTouch = false
        }else{
            ratingNumber.rating = 0.0
            ratingNumber.settings.updateOnTouch = true
        }
        initClickBtnSendAssign()
    }
    
    func initClickBtnSendAssign(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickBtnSendAssign(_:)))
        btnSendAssign.isUserInteractionEnabled = true
        btnSendAssign.addGestureRecognizer(tap)
    }
    
    func clickBtnSendAssign(_ sender: UITapGestureRecognizer) {
        let parameters: Parameters! = [
            "useriduser":user._iduser,
            "useridcompany":userCompany._iduser,
            "numstart": Int(ratingNumber.rating),
            "contentcomment":comment.text!,
            "datecomment":Date().millisecondsSince1970
        ]
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_ADD_ASSIGNMENT, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
//                    print(json)
                    self.processResponseAddAssign(json: json)
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        self.popupWarningConnection()
                    }
                    break
                }
                SVProgressHUD.dismiss()
            })
    }
    
    func processResponseAddAssign(json:JSON){
        let code = json["code"].string! as String
        switch code {
        case CodeServer.CODE_1000:
            self.emitDataSocketLocal(event: "updateAssignment", data: 1000 as AnyObject)
            hidePopup()
            break
        default:
            break
        }
    }
    
    func hidePopup() {
        self.view.alpha = 1.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0.0
        }
    }
    
    func showAnimate(){
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) { 
            self.view.alpha = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if (touch?.view != viewContent && touch?.view != ratingNumber && touch?.view != btnSendAssign)  {
            hidePopup()
        }
    }
    
}
