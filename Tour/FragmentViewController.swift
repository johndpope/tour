//
//  FragmentViewController.swift
//  Tour
//
//  Created by tnt on 7/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class FragmentViewController: UIViewController {

    var animateDefault:Int = 0
    var tourRec:Tour!
    var listUseroftour:[Useroftour] = [Useroftour]()
    var listUseroftourbackup:[Useroftour]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func setShowAnimate(type:Int){
        switch type {
        case animateDefault:
            self.view.transform = CGAffineTransform(scaleX: 0.8,y: 0.8)
            UIView.animate(withDuration: 0.1) {
                self.view.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
            }
            break
        default:
            break
        }
    }
    func getListUseroftour(completion: @escaping ([Useroftour]) -> () ){
        let parameters: Parameters! = [
            "idtour":tourRec._idtour
        ]
        //        print(parameters)
        Alamofire.request(GetDataFromURL.URL_GET_ALL_USEROFTOUR_OF_TOUR, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    let code = json["code"].string! as String
                    let data = json["data"]
                    if code == CodeServer.CODE_1000{
                        let listUseroftour:[Useroftour] = self.fetchListUseroftour(listUseroftour: Useroftour.parseArrayJson(arrayjson: data["useroftours"]))
                        self.listUseroftourbackup = listUseroftour
                        completion(listUseroftour)
                    }
//                    print(json)
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
    
    func searchListUseroftour(char:String, listUseroftour:[Useroftour]) -> [Useroftour]{
        var lu:[Useroftour] = [Useroftour]()
        if char == "" {
            return listUseroftour
        }
        for u in listUseroftour {
            if u._name.lowercased().range(of: char.lowercased()) != nil{
                lu.append(u)
            }
        }
        return lu
    }
    
    func fetchListUseroftour(listUseroftour: [Useroftour]) -> [Useroftour]{
        //loai ban~ than^ ra khoi danh sach
        var lu:[Useroftour] = [Useroftour]()
        if let user = self.getDataSocketLocal(event: "logged") as? User{
            for item in listUseroftour{
                if item._username != user._username{
                    lu.append(item)
                }
            }
        }
        return lu
    }
}
