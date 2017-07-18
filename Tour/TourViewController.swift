//
//  TourViewController.swift
//  Tour
//
//  Created by tnt on 6/26/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
class TourViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var totalTour: UILabel!
    @IBOutlet weak var btnShowAndHideMenu: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewTour: UITableView!
    
    var currentPage:Int = Int()
    var listTour:[Tour] = [Tour]()
    var scheduleSend:[Schedule] = [Schedule]()
    var end:Bool = false
    var indexSendSchedue:Int!
    var indexSendTourProgram:Int!
    var indexSendDetailTour:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayour()
        tableViewTour.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "TourTableViewCell", bundle: nil)
        self.tableViewTour.register(nib, forCellReuseIdentifier: "TourTableViewCell")
        getListTour(page: 0)
    }

    func initLayour(){
        self.layoutButtonNav(btnShowAndHideMenu: btnShowAndHideMenu)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("cccccccc")
//        for txt in self.view.subviews {
//            print(txt)
//        }
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        end = false
//        print("search")
        getListTour(page: 0)
    }
    func getListTour(page:Int){
        let charsearch:String = searchBar.text!
        let parameters: Parameters! = [
            "page":page,
            //            "record":2,
            "charsearch":charsearch
        ]
//        print(parameters)
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_USEROFTOUR_GET_TOUR, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            
            .responseJSON( completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    print(json)
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
            let page:Int = Int(String(describing: data["page"]))!
            self.currentPage = page
            
            if page == 0 {
                listTour = [Tour]()
            }
            if page+1 == Int(String(describing: data["totalpage"]))! {
                self.end = true
            }
            let listTourjson = data["items"]
            //            print(listTourjson)
            
            for i in 0 ..< listTourjson.count {//ko parse array vi giu~ lai du~ lieu truoc do
                let tourjson = listTourjson[i]
                listTour.append(Tour.parseJson(tourjson: tourjson))
            }
            
            break
        case CodeServer.CODE_1003:
            listTour = [Tour]()
            break
        default:
            break
        }
        tableViewTour.reloadData()
    }
}

extension TourViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.totalTour.text = "Tổng số tour "+String(listTour.count)
        return listTour.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TourTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TourTableViewCell", for: indexPath) as! TourTableViewCell
        let imagetour:[String] = listTour[indexPath.row]._imagetour
        cell.slideShow.auk.removeAll()
        for i in imagetour {
            cell.slideShow.auk.show(url: i)
            cell.slideShow.auk.settings.contentMode = .scaleToFill
        }
        cell.slideShow.auk.startAutoScroll(delaySeconds: 4)
        
        cell.idtour.text = String(listTour[indexPath.row]._idtour)
        cell.nametour.text = listTour[indexPath.row]._name
        cell.slogan.text = listTour[indexPath.row]._slogan
        cell.timestart.text = Date.init(milliseconds: listTour[indexPath.row]._timestart).convertMilisecondsToDateString()
        cell.timeend.text = Date.init(milliseconds: listTour[indexPath.row]._timeend).convertMilisecondsToDateString()
        cell.totalseat.text = String(listTour[indexPath.row]._totalseat)
        cell.timetour.text = listTour[indexPath.row]._timetour
        cell.ispickup.text = listTour[indexPath.row].getIspickup()
        let maxPrice:InfoPrice = InfoPrice.getMaxInfoPriceItem(arrayInfoPrice: listTour[indexPath.row]._infoprice)
        let text = String(maxPrice._price)+" "+maxPrice._currency
        if ( maxPrice._price > maxPrice._pricediscount && maxPrice._pricediscount > 0){
            cell.pricediscount.text = String(maxPrice._pricediscount)+maxPrice._currency
            cell.pricediscount.isHidden = false
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName , value: 2, range: textRange)
            
            cell.price.attributedText = attributedText
        }else{
            cell.pricediscount.isHidden = true
            cell.price.text = text
        }
        cell.initData(tour: listTour[indexPath.row], tableView: self.tableViewTour)
        cell.showTourRank()
        if listTour[indexPath.row]._statustableview == 0{
            cell.heightDVKKT.constant = CGFloat(0)
            cell.btnDVKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
            cell.lbBtnDVKT.textColor = UIColor.white
            cell.btnDVKKT.backgroundColor = UIColor.white
            cell.lbBtnDVKKT.textColor = UIColor.black
            
            cell.hideAll()
            cell.showDVKT()
        }else{
            cell.heightCollectionViewDVKT.constant = CGFloat(0)
            cell.heightDVKKT.constant = CGFloat(21 * listTour[indexPath.row].getListComment().count)
            cell.dvkkt.text = listTour[indexPath.row]._comment
            
            cell.btnDVKKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
            cell.lbBtnDVKKT.textColor = UIColor.white
            cell.btnDVKT.backgroundColor = UIColor.white
            cell.lbBtnDVKT.textColor = UIColor.black
        }
        
        cell.btnDVKT.tag = indexPath.row
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.btnClickDVKT(_:)))
        cell.btnDVKT.isUserInteractionEnabled = true
        cell.btnDVKT.addGestureRecognizer(tap1)
        
        cell.btnDVKKT.tag = indexPath.row
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.btnClickDVKKT(_:)))
        cell.btnDVKKT.isUserInteractionEnabled = true
        cell.btnDVKKT.addGestureRecognizer(tap2)
        
        cell.btnSchedule.tag = indexPath.row
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.btnClickSchedule(_:)))
        cell.btnSchedule.isUserInteractionEnabled = true
        cell.btnSchedule.addGestureRecognizer(tap3)
        
        cell.btnTourProgram.tag = indexPath.row
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.btnClickTourProgram(_:)))
        cell.btnTourProgram.isUserInteractionEnabled = true
        cell.btnTourProgram.addGestureRecognizer(tap4)
        
        cell.viewBtnShowDetailTour.tag = indexPath.row
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.btnClickViewGotoDetailTour(_:)))
        cell.viewBtnShowDetailTour.isUserInteractionEnabled = true
        cell.viewBtnShowDetailTour.addGestureRecognizer(tap5)
    
        initlayer(v: cell.viewcontent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TourTableViewCell
        initlayer(v: cell.viewcontent)
    }
    
    func btnClickDVKT(_ sender:UIGestureRecognizer){
        self.tableViewTour.beginUpdates()
        listTour[sender.view!.tag]._statustableview = 0
        let cell:TourTableViewCell = self.tableViewTour.cellForRow(at: IndexPath(row: sender.view!.tag, section: 0)) as! TourTableViewCell
        cell.hideAll()
        cell.heightDVKKT.constant = CGFloat(0)
        cell.btnDVKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
        cell.lbBtnDVKT.textColor = UIColor.white
        cell.btnDVKKT.backgroundColor = UIColor.white
        cell.lbBtnDVKKT.textColor = UIColor.black
        cell.initData(tour: listTour[sender.view!.tag], tableView:self.tableViewTour)
        cell.showDVKT()
        initlayer(v: cell.contentView)
        self.tableViewTour.endUpdates()
    }
    func btnClickDVKKT(_ sender:UIGestureRecognizer){
        self.tableViewTour.beginUpdates()
        listTour[sender.view!.tag]._statustableview = 1
        let cell:TourTableViewCell = self.tableViewTour.cellForRow(at: IndexPath(row: sender.view!.tag, section: 0)) as! TourTableViewCell
        cell.hideAll()
        cell.heightCollectionViewDVKT.constant = CGFloat(0)
        cell.heightDVKKT.constant = CGFloat(21 * listTour[sender.view!.tag].getListComment().count)
        cell.dvkkt.text = listTour[sender.view!.tag]._comment
        
        cell.btnDVKKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
        cell.lbBtnDVKKT.textColor = UIColor.white
        cell.btnDVKT.backgroundColor = UIColor.white
        cell.lbBtnDVKT.textColor = UIColor.black
        initlayer(v: cell.contentView)
        self.tableViewTour.endUpdates()
    }
    
    func btnClickSchedule(_ sender: UIGestureRecognizer){
        indexSendSchedue = sender.view?.tag
        self.performSegue(withIdentifier:  "gotoScheduleFromTour", sender: self)
    }
    
    func btnClickTourProgram(_ sender: UIGestureRecognizer){
        indexSendTourProgram = sender.view?.tag
        self.performSegue(withIdentifier:  "gotoTourprogramFromTour", sender: self)
    }
    func btnClickViewGotoDetailTour(_ sender: UIGestureRecognizer){
        indexSendDetailTour = sender.view?.tag
        self.performSegue(withIdentifier:  "gotoDetailFromTour", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "gotoScheduleFromTour":
            if let des = segue.destination as? ScheduleViewController{
                des.tourRec = listTour[indexSendSchedue]
            }
            break
        case "gotoTourprogramFromTour":
            if let des = segue.destination as? TourProgramViewController{
                des.tourRec = listTour[indexSendTourProgram]
//                print(listTour[indexSendTourProgram]._tourProgram)
            }
            break
        case "gotoDetailFromTour":
            if let des = segue.destination as? DetailTourViewController{
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                des.tourRec = listTour[indexSendDetailTour]
            }
            break
        default:
            break
        }
    }
    
}
