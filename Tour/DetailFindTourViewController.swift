import UIKit
import Kingfisher
import PopupDialog
import DatePickerDialog
import STZPopupView
import DropDown
import Alamofire
import SVProgressHUD
import SwiftyJSON
import moa
import Auk
class DetailFindTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var imageAvatar: UIImageViewAvatar!
    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewSearchBar: UIView!
    var userRec:User!
    var isHiddenViewTitle:Bool = true
    @IBOutlet weak var viewButtonFind: UILabel!
    @IBOutlet weak var searchBarButton: UISearchBar!
    @IBOutlet weak var timestartfind: UILabel!
    @IBOutlet weak var constraintFind: NSLayoutConstraint!
    
    var showFind:Bool = true
    var itemstartselected:Int = 0
    var itemendselected:Int = 0
    var itemvehicletypeselected:Int = 0
    var itempriceselected:Int = 0
    var typePicker:Int!
    var currentPage:Int = Int()
    var listTour:[Tour] = [Tour]()
    var end:Bool = false
    var timestartfindsearch:Int64 = 0
    var isfind:Bool = false
    var tourSendDetail:Tour!
    
    let dropDownPlacestart = DropDown()
    let dropDownPlaceend = DropDown()
    let dropDownVehicleType = DropDown()
    let dropDownPriceTour = DropDown()
    
    @IBOutlet weak var tableViewTour: UITableView!
    @IBOutlet weak var placestart: UILabel!
    @IBOutlet weak var placeend: UILabel!
    @IBOutlet weak var vehicletype: UILabel!
    @IBOutlet weak var pricetour: UILabel!
    @IBOutlet weak var viewFind: UIView!
    @IBOutlet weak var viewPlaceStart: UIView!
    @IBOutlet weak var viewPlaceEnd: UIView!
    @IBOutlet weak var viewVehicleType: UIView!
    @IBOutlet weak var viewPriceTour: UIView!
    
    @IBOutlet weak var ispickup: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initNavBar()
        initButtonFind()
        initLayoutDropdown()
        getListTour(page: 0)
    }
    func initButtonFind(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(showFind(_:)))
        viewButtonFind.isUserInteractionEnabled = true
        viewButtonFind.addGestureRecognizer(tap)
        constraintFind.constant = -200
    }
    func initLayoutDropdown(){
        dropDownPlacestart.anchorView = viewPlaceStart
        dropDownPlacestart.dataSource = DataGlobals.Provincial
        dropDownPlacestart.bottomOffset = CGPoint(x: 0, y:(dropDownPlacestart.anchorView?.plainView.bounds.height)!)
        dropDownPlacestart.topOffset = CGPoint(x: 0, y:-(dropDownPlacestart.anchorView?.plainView.bounds.height)!)
        let tapplacestart = UITapGestureRecognizer(target: self, action: #selector(showDropdownPlaceStart(_:)))
        viewPlaceStart.isUserInteractionEnabled = true
        viewPlaceStart.addGestureRecognizer(tapplacestart)
        dropDownPlacestart.selectionAction = { [unowned self] (index: Int, item: String) in
            self.placestart.text = item
            print("Selected item: \(item) at index: \(index)")
            self.itemstartselected = index
        }
        
        
        dropDownPlaceend.anchorView = viewPlaceEnd
        dropDownPlaceend.dataSource = DataGlobals.Provincial
        dropDownPlaceend.bottomOffset = CGPoint(x: 0, y:(dropDownPlaceend.anchorView?.plainView.bounds.height)!)
        dropDownPlaceend.topOffset = CGPoint(x: 0, y:-(dropDownPlaceend.anchorView?.plainView.bounds.height)!)
        let tapplaceend = UITapGestureRecognizer(target: self, action: #selector(showDropdownPlaceEnd(_:)))
        viewPlaceEnd.isUserInteractionEnabled = true
        viewPlaceEnd.addGestureRecognizer(tapplaceend)
        dropDownPlaceend.selectionAction = { [unowned self] (index: Int, item: String) in
            self.placeend.text = item
            print("Selected item: \(item) at index: \(index)")
            self.itemendselected = index
        }
        
        dropDownVehicleType.anchorView = viewVehicleType
        dropDownVehicleType.dataSource = DataGlobals.VehicleType
        dropDownVehicleType.bottomOffset = CGPoint(x: 0, y:(dropDownVehicleType.anchorView?.plainView.bounds.height)!)
        dropDownVehicleType.topOffset = CGPoint(x: 0, y:-(dropDownVehicleType.anchorView?.plainView.bounds.height)!)
        let tagvehicletype = UITapGestureRecognizer(target: self, action: #selector(showDropdownVehicleType(_:)))
        viewVehicleType.isUserInteractionEnabled = true
        viewVehicleType.addGestureRecognizer(tagvehicletype)
        dropDownVehicleType.selectionAction = { [unowned self] (index: Int, item: String) in
            self.vehicletype.text = item
            print("Selected item: \(item) at index: \(index)")
            self.itemvehicletypeselected = index
        }
        
        dropDownPriceTour.anchorView = viewPriceTour
        dropDownPriceTour.dataSource = DataGlobals.Price
        dropDownPriceTour.bottomOffset = CGPoint(x: 0, y:(dropDownPriceTour.anchorView?.plainView.bounds.height)!)
        dropDownPriceTour.topOffset = CGPoint(x: 0, y:-(dropDownPriceTour.anchorView?.plainView.bounds.height)!)
        let tagpricetour = UITapGestureRecognizer(target: self, action: #selector(showDropdownPriceTour(_:)))
        viewPriceTour.isUserInteractionEnabled = true
        viewPriceTour.addGestureRecognizer(tagpricetour)
        dropDownPriceTour.selectionAction = { [unowned self] (index: Int, item: String) in
            self.pricetour.text = item
            print("Selected item: \(item) at index: \(index)")
            self.itempriceselected = index
        }
    }
    
    //        let listpic = menu[indexPath.row]
    //        for i in listpic {
    //        cell.slideshow.auk.show(url: i)
    //        }
    //        cell.slideshow.auk.startAutoScroll(delaySeconds: 4)
    
    func showDropdownPlaceStart(_ sender: UITapGestureRecognizer){
        dropDownPlacestart.show()
    }
    func showDropdownPlaceEnd(_ sender: UITapGestureRecognizer){
        dropDownPlaceend.show()
    }
    func showDropdownVehicleType(_ sender: UITapGestureRecognizer){
        dropDownVehicleType.show()
    }
    func showDropdownPriceTour(_ sender: UITapGestureRecognizer){
        dropDownPriceTour.show()
    }
    
    /*func initNavBar(){
        let url  = URL(string :self.geturl(url: userRec._logocompany))
        imageAvatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_vn"), options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        nameCompany.text = userRec._namecompany
        searchBarButton.placeholder = "Nhập tên tour..."
    }*/
    
    func showFind(_ sender: UITapGestureRecognizer){
        if(showFind){
            isfind = true
            constraintFind.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            getListTour(page: 0)
            constraintFind.constant = -200
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        showFind = !showFind
    }
    
    @IBAction func btnSelectDate(_ sender: Any) {
        DatePickerDialog().show(title: "Date", doneButtonTitle: "OK", cancelButtonTitle: "Cancel", datePickerMode: .date) { (date) in
            if date != nil {
                let d:String = String(Calendar.current.component(.day, from: date!))
                let m:String = String(Calendar.current.component(.month, from: date!))
                let y:String = String(Calendar.current.component(.year, from: date!))
                let stringdateselect:String = d+"-"+m+"-"+y
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                let dateselect:Date = formatter.date(from: stringdateselect)!
                
                
                let datenow:Date = Date()
                let dn:String = String(Calendar.current.component(.day, from: datenow))
                let mn:String = String(Calendar.current.component(.month, from: datenow))
                let yn:String = String(Calendar.current.component(.year, from: datenow))
                let stringdatenow:String = dn+"-"+mn+"-"+yn
                let datenownotime:Date = formatter.date(from: stringdatenow)!
                
                if dateselect.millisecondsSince1970 >= datenownotime.millisecondsSince1970{
                    self.timestartfindsearch = dateselect.millisecondsSince1970
                    self.timestartfind.text = stringdateselect
                }else{
                    self.timestartfind.text = "Tất cả"
                    self.timestartfindsearch = 0
                }
            }else{
                
            }
        }
    }
    
    
    @IBAction func buttonSearchBar(_ sender: UIBarButtonItem) {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 250
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTour.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DetailFindTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailFindTableViewCell", for: indexPath) as! DetailFindTableViewCell
        
        let imagetour:[String] = listTour[indexPath.row]._imagetour
        cell.slideShow.auk.removeAll()
        for i in imagetour {
            cell.slideShow.auk.show(url: i)
            cell.slideShow.auk.settings.contentMode = .scaleToFill
        }
        cell.slideShow.auk.startAutoScroll(delaySeconds: 4)
        cell.nametour.text = listTour[indexPath.row]._name
        cell.slogan.text = listTour[indexPath.row]._slogan
        cell.seal.text = String(listTour[indexPath.row]._totalseat - listTour[indexPath.row]._totaluser)
        cell.timestart.text = Date.init(milliseconds: listTour[indexPath.row]._timestart).convertMilisecondsToDateString()
        cell.countdown.text = Date.init(milliseconds: listTour[indexPath.row]._timestart).offsetWithCurrentTime()
        
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
            cell.price.text = text
        }
        
        cell.btnDetailInfo.tag = indexPath.row
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.clickDetailInfo(_:)))
        cell.btnDetailInfo.isUserInteractionEnabled = true
        cell.btnDetailInfo.addGestureRecognizer(tap2)
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//                let cell = cell as! DetailFindTableViewCell
//                //        cell.viewcontent.layer.cornerRadius = 10
//                let shadowPath2 = UIBezierPath(rect: cell.viewcontent.bounds)
//                //        cell.viewcontent.layer.masksToBounds = false
//                cell.viewcontent.layer.shadowColor = UIColor.black.cgColor
//                cell.viewcontent.layer.shadowOpacity = 0.5
//                cell.viewcontent.layer.shadowPath = shadowPath2.cgPath
//                cell.viewcontent.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        if indexPath.row+1 == listTour.count {
            if self.end == false {
                currentPage += 1
                getListTour(page: currentPage)
            }else {
                print("the end")
            }
        }
        
    }
    
    func clickDetailInfo(_ sender:UITapGestureRecognizer){
        if let view = sender.view {
            tourSendDetail = listTour[view.tag]
            let backItem = UIBarButtonItem()
            backItem.title = tourSendDetail._name
            navigationItem.backBarButtonItem = backItem
            self.performSegue(withIdentifier: "gotoDetailInfoFromDetailFind", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "gotoDetailInfoFromDetailFind":
            if let des = segue.destination as? DetailInfoTourViewController{
                des.tourRec = tourSendDetail
            }
            break
        default:
            break
        }
        
    }
    
    func getListTour(page:Int){
        //let charsearch:String = searchBarButton.text!
        let charsearch:String = ""
        if(!isfind){
            let parameters: Parameters! = [
                "page":page,
                "iduser":userRec._iduser,
                "charsearch":charsearch
            ]
//            print(parameters)
            SVProgressHUD.show()
            Alamofire.request(GetDataFromURL.URL_GET_TOUR_DETAIL, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
                .validate(statusCode: 200..<300)
                //.validate(contentType: ["application/json"])
                .responseJSON(/*queue: queue ,*/ completionHandler:  {
                    response in
                    switch(response.result) {
                    case .success(_):
                        let json = JSON(data:response.data!)
//                        print(json)
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
        }else{
            var ispickupdata:Int = 0
            var tourprice1:Double = 0
            var tourprice2:Double = 0
            if ispickup.isChecked {
                ispickupdata = 1
            }
            
            switch itempriceselected {
            case 0:
                tourprice2 = 5000000000
                break
            case 1:
                tourprice2 = 2000000
                break
            case 2:
                tourprice1 = 2000000
                tourprice2 = 5000000
                break
            case 3:
                tourprice1 = 5000000
                tourprice2 = 10000000
                break
            case 4:
                tourprice1 = 10000000
                tourprice2 = 20000000
                break
            case 5:
                tourprice1 = 20000000
                tourprice2 = 5000000000
                break
            default:
                break
            }
            
            var beginplace:String = ""
            if placestart.text! != "Tất cả" {
                beginplace = placestart.text!
            }
            var targetplace:String = ""
            if placeend.text != "Tất cả" {
                targetplace = placeend.text!
            }
            var typevehicle:String = ""
            if vehicletype.text! != "Tất cả" {
                typevehicle = vehicletype.text!
            }
            let parameters: Parameters! = [
                "page":page,
                "iduser":userRec._iduser,
                "charsearch":charsearch,
                "ispickup":ispickupdata,
                "timestart":timestartfindsearch,
                "beginplace":beginplace,
                "targetplace":targetplace,
                "typevehicle":typevehicle,
                "tourprice1":tourprice1,
                "tourprice2":tourprice2
            ]
//                                print(parameters)
            SVProgressHUD.show()
            Alamofire.request(GetDataFromURL.URL_FIND_TOUR_DETAIL, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        end = false
        getListTour(page: 0)
    }
}
