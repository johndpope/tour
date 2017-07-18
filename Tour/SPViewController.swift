//
//  SPViewController.swift
//  Tour
//
//  Created by tnt on 7/8/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
import Kingfisher

class SPViewController: UIViewController {
    
    var userRec:User!
    @IBOutlet weak var heightCollectionSupport: NSLayoutConstraint!
    @IBOutlet weak var collectionSupport: UICollectionView!
    var listUserSupport:[User] = [User]()
    
    
    @IBOutlet weak var tableLastMessage: UITableView!
    @IBOutlet weak var heightLastMessage: NSLayoutConstraint!
    var listLastMessage:[Message] = [Message]()
    
    var currentPage:Int = 0
    var isLoading:Bool = false
    var end:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        collectionSupport.register(nib, forCellWithReuseIdentifier: "UserCollectionViewCell")
        getEmployee()
        
        let nib2 = UINib(nibName: "LastMessageTableViewCell", bundle: nil)
        tableLastMessage.register(nib2, forCellReuseIdentifier: "LastMessageTableViewCell")
        getListLastMessage(page: 0)
        
        self.tableLastMessage.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    deinit {
        self.tableLastMessage.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableLastMessage.layer.removeAllAnimations()
        heightLastMessage.constant = tableLastMessage.contentSize.height
    }
    
    func getListLastMessage(page:Int){
        if let user = self.getDataSocketLocal(event: "logged") as? User{
        let parameters: Parameters! = [
            "page":page,
            "usersender":user._username
        ]
        print(parameters)
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_GET_LIST_LAST_MESSAGE, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            
            .responseJSON( completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    self.processResponseLastMessage(json: json)
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
    }
    
    func processResponseLastMessage(json:JSON){
        print(json)
        let code = json["code"].string! as String
        switch code {
        case CodeServer.CODE_1000:
            let data = json["data"]
            let page:Int = Int(String(describing: data["page"]))!
            self.currentPage = page
            
            if page == 0 {
                listLastMessage = [Message]()
            }
            if page+1 == Int(String(describing: data["totalpage"]))! {
                self.end = true
            }
            let listTourjson = data["items"]
            
            for i in 0 ..< listTourjson.count {//ko parse array vi giu~ lai du~ lieu truoc do
                let tourjson = listTourjson[i]
                listLastMessage.append(Message.parseJson(jsonobject: tourjson))
            }
            break
        case CodeServer.CODE_1003:
            listLastMessage = [Message]()
            break
        default:
            break
        }
    
        tableLastMessage.reloadData()
    }
    
    func getEmployee(){
        let parameters: Parameters! = [
            "iduser":4
        ]
        //print(parameters)
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_GET_EMPLOYEE, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    self.processResponse(json: json)
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
    
    func processResponse(json:JSON){
        let code = json["code"].string! as String
        switch code {
        case CodeServer.CODE_1000:
            let data = json["data"]
            
            let listuserjson = data["items"]
            for i in 0 ..< listuserjson.count {
                let userjson = listuserjson[i]
                listUserSupport.append(User.parseJson(userjson: userjson))
            }
            break
        case CodeServer.CODE_1003:
            listUserSupport = [User]()
            break
        default:
            break
        }
        collectionSupport.reloadData()
    }
}

extension SPViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listUserSupport.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let url  = URL(string :self.geturl(url: listUserSupport[indexPath.row]._avatar))
        cell.avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo")	, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        cell.name.text = listUserSupport[indexPath.row]._detailname
        return cell
    }
}

extension SPViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLastMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastMessageTableViewCell", for: indexPath) as! LastMessageTableViewCell
        cell.name.text = listLastMessage[indexPath.row]._detailname
        let url  = URL(string :self.geturl(url: listLastMessage[indexPath.row]._avatar))
        cell.avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo"), options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        cell.content.text = listLastMessage[indexPath.row]._content
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        print(maximumOffset - currentOffset)
        if maximumOffset - currentOffset <= 100.0 {
            if self.end == false {
                currentPage += 1
                getListLastMessage(page: currentPage)
            }else {
                print("the end")
            }
        }
    }
}
