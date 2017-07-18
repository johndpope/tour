//
//  HAViewController.swift
//  Tour
//
//  Created by tnt on 7/8/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
import moa
import Auk
class HAViewController: UIViewController {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tableVIewActivitiesImage: UITableView!
    var userRec:User!
    var currentPage:Int = 0
    var end:Bool = false
    var isLoading:Bool = false
    var listActivitiesImage:[ActivitiesImage] = [ActivitiesImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HATableViewCell", bundle: nil)
        tableVIewActivitiesImage.register(nib, forCellReuseIdentifier: "HATableViewCell")
        getListActivitiesImage(page: 0)
    }
    
    func getListActivitiesImage(page:Int){
        if isLoading == false {
            isLoading = true
            let parameters: Parameters! = [
                "page":page,
                "iduser":4,
                "charsearch":""
            ]
            //        print(parameters)
            SVProgressHUD.show()
            Alamofire.request(GetDataFromURL.URL_GET_ACTIVITIESIMAGE, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
                .validate(statusCode: 200..<300)
                //.validate(contentType: ["application/json"])
                .responseJSON(/*queue: queue ,*/ completionHandler:  {
                    response in
                    self.isLoading = false
                    switch(response.result) {
                    case .success(_):
                        let json = JSON(data:response.data!)
                        self.processResponse(json: json)
                        print(json)
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
    func processResponse(json:JSON){
        let code = json["code"].string! as String
        switch code {
        case CodeServer.CODE_1000:
            let data = json["data"]
            let page:Int = Int(String(describing: data["page"]))!
            let totalitem:Int = Int(String(describing: data["totalitem"]))!
            self.total.text = "Tổng số hoạt động: " + String(totalitem)
            self.currentPage = page
            if page == 0 {
                listActivitiesImage = [ActivitiesImage]()
            }
            if page+1 == Int(String(describing: data["totalpage"]))! {
                self.end = true
            }
            let listuserjson = data["items"]
            for i in 0 ..< listuserjson.count {
                let userjson = listuserjson[i]
                listActivitiesImage.append(ActivitiesImage.parseJson(jsonobject: userjson))
            }
            break
        case CodeServer.CODE_1003:
            listActivitiesImage = [ActivitiesImage]()
            break
        default:
            break
        }
        tableVIewActivitiesImage.reloadData()
    }
}

extension HAViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listActivitiesImage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HATableViewCell", for: indexPath) as! HATableViewCell
        initlayer(v: cell.viewcontent)
        cell.title.text = listActivitiesImage[indexPath.row]._nameactivity + " - Ngày: " + Date.init(timezone: listActivitiesImage[indexPath.row]._timeactivity).convertDateString()
        
        let images:[String] = listActivitiesImage[indexPath.row]._urlimages
        cell.slideShow.auk.removeAll()
        for i in images {
            cell.slideShow.auk.show(url: i)
            cell.slideShow.auk.settings.contentMode = .scaleToFill
        }
        cell.slideShow.auk.startAutoScroll(delaySeconds: 4)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1 == listActivitiesImage.count {
            if self.end == false {
                currentPage += 1
                getListActivitiesImage(page: currentPage)
            }else {
                print("the end")
            }
        }
    }
}
