//
//  GTViewController.swift
//  Tour
//
//  Created by tnt on 7/7/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import SwiftCharts
import SwiftyJSON 
import SVProgressHUD
import Alamofire
import Kingfisher
import Cosmos

class GTViewController: UIViewController {
    var userRec:User!
    @IBOutlet weak var avatar: UIImageViewAvatar!
    @IBOutlet weak var namecompany: UILabel!
    @IBOutlet weak var totalview: UILabel!
    @IBOutlet weak var seat: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var taxcode: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var sofax: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var fanpage: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var imagelike: UIImageView!
    @IBOutlet weak var btnLike: GradientViewButton!
    @IBOutlet weak var dgia: GradientViewButton!
    @IBOutlet weak var share: GradientViewButton!
    @IBOutlet weak var viewInfoUserCompany: UIView!
    @IBOutlet weak var heightInfoUsercompany: NSLayoutConstraint!
    
    @IBOutlet weak var numberStartAVG: CosmosView!
    @IBOutlet weak var lbNumberStar: UILabel!
    @IBOutlet weak var chartView: UIView!
    var arrayChartBar:[ChartStackedBarModel] = [ChartStackedBarModel]()
    let sideSelectorHeight: CGFloat = 0
    fileprivate var chart: Chart? // arc
    
    var listUserAssignment:[AssignmentUser] = [AssignmentUser]()
    var currentPage:Int = 0
    var end:Bool = false
    var isLoading:Bool = false
    @IBOutlet weak var tableAssignmentUser: UITableView!
    @IBOutlet weak var heightTableAssignment: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        chartView.backgroundColor = Color.black
        initViewUser()
        getNumberStart()
        initButtonView()
        getListAssignment(page: 0)
        self.tableAssignmentUser.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    deinit {
        self.tableAssignmentUser.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableAssignmentUser.layer.removeAllAnimations()
        heightTableAssignment.constant = tableAssignmentUser.contentSize.height
    }

    func getListAssignment(page:Int){
        if isLoading == false {
            isLoading = true
        let iduser = userRec._iduser!
        let parameters: Parameters! = [
            "page":page,
            "useridcompany":iduser,
            ]
        //        print(parameters)
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_GET_ASSIGNMENT_COMPANY, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                self.isLoading = false
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
                listUserAssignment = [AssignmentUser]()
            }
            if page+1 == Int(String(describing: data["totalpage"]))! {
                self.end = true
            }
            let listuserjson = data["items"]
            for i in 0 ..< listuserjson.count {
                let userjson = listuserjson[i]
                listUserAssignment.append(AssignmentUser.parseJson(assignmentUserJSON: userjson))
            }
            break
        case CodeServer.CODE_1003:
            listUserAssignment = [AssignmentUser]()
            break
        default:
            break
        }
        tableAssignmentUser.reloadData()
    }
    func initButtonView(){
        let tapassign = UITapGestureRecognizer(target: self, action: #selector(eventClickButtonAssign(_:)))
        dgia.isUserInteractionEnabled = true
        dgia.addGestureRecognizer(tapassign)
        
        let taplike = UITapGestureRecognizer(target: self, action: #selector(eventClickButtonLike(_:)))
        btnLike.isUserInteractionEnabled = true
        btnLike.addGestureRecognizer(taplike)
        
        let tapshare = UITapGestureRecognizer(target: self, action: #selector(eventClickButtonShare(_:)))
        share.isUserInteractionEnabled = true
        share.addGestureRecognizer(tapshare)
    }
    
    func eventClickButtonAssign(_ sender:UIGestureRecognizer){
        if let _:User = self.getDataSocketLocal(event: "logged") as? User{
            let popupAssignVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupAssignViewController") as! PopupAssignViewController
            popupAssignVC.userCompany = userRec
            self.addChildViewController(popupAssignVC)
            popupAssignVC.view.frame = self.view.frame
            self.view.addSubview(popupAssignVC.view)
            popupAssignVC.didMove(toParentViewController: self)
            
        }else{
            self.alertLoginOrRegister()
        }
    }
    func eventClickButtonLike(_ sender:UIGestureRecognizer){
        if let myuser:User = self.getDataSocketLocal(event: "logged") as? User{
                let usercompany:User = userRec
                
                let parameters: Parameters! = [
                    "useridcompany":usercompany._iduser,
                    "useriduser":myuser._iduser,
                    ]
                //        print(parameters)
                SVProgressHUD.show()
                Alamofire.request(GetDataFromURL.URL_LIKE_USER_COMPANY, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
                    .validate(statusCode: 200..<300)
                    //.validate(contentType: ["application/json"])
                    .responseJSON(/*queue: queue ,*/ completionHandler:  {
                        response in
                        switch(response.result) {
                        case .success(_):
                            let json = JSON(data:response.data!)
                            let code = json["code"].string! as String
                            if code == CodeServer.CODE_1000 {
                                if(usercompany._user == ""){
                                    usercompany._like = usercompany._like + 1
                                    usercompany._user = String(myuser._iduser)
                                    self.imagelike.image = #imageLiteral(resourceName: "ic_like")
                                }else{
                                    usercompany._like = usercompany._like - 1
                                    usercompany._user = ""
                                    self.imagelike.image = #imageLiteral(resourceName: "ic_nolike")
                                }
                                self.like.text = String(usercompany._like)
                            }
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
            self.alertLoginOrRegister()
        }
    }
    
    func eventClickButtonShare(_ sender:UIGestureRecognizer){
        print("share")
    }
    
    func initViewUser(){
        let url  = URL(string :self.geturl(url: userRec._logocompany))
        avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_vn"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
        namecompany.text = getTextViewLabel(text: userRec._namecompany)
        taxcode.text = getTextViewLabel(text: userRec._taxcode)
        address.text = getTextViewLabel(text: userRec._address)

        phone.text = getTextViewLabel(text: userRec._phone)
        email.text = getTextViewLabel(text: userRec._email)
        sofax.text = getTextViewLabel(text: userRec._sofax)
        website.text = getTextViewLabel(text: userRec._website)
        fanpage.text = getTextViewLabel(text: userRec._fanpage)
        totalview.text = String(userRec._review)
        seat.text = String(userRec._totaltour)
        like.text = String(userRec._like)
        distance.text = String(userRec._distance)+" km"
        
        if userRec._user == "" {
            imagelike.image = #imageLiteral(resourceName: "ic_nolike")
        }else{
            imagelike.image = #imageLiteral(resourceName: "ic_like")
        }
        
    }
    func getTextViewLabel(text:String) -> String{
        if text == "" {
            return "Chưa cập nhật"
        }else{
            return text
        }
    }
    
    func getNumberStart(){
        let iduser = userRec._iduser!
        let parameters: Parameters! = [
            "useridcompany":iduser
        ]
        //                print(parameters)
        SVProgressHUD.show()
        Alamofire.request(GetDataFromURL.URL_GET_ASSIGNMENT_NUMSTART, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
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
            //            print(data)
            calculatorNumberStart(data: data["items"][0])
            break
        default:
            break
        }
    }
    func calculatorNumberStart(data:JSON){
        var totalNumstart:Int = 0
        var totalAssign:Int = 0
        let numstart1 = data["numstart1"].int!
        totalNumstart+=numstart1
        totalAssign+=numstart1
        let numstart2 = data["numstart2"].int!
        totalNumstart+=numstart2*2
        totalAssign+=numstart2
        let numstart3 = data["numstart3"].int!
        totalNumstart+=numstart3*3
        totalAssign+=numstart3
        let numstart4 = data["numstart4"].int!
        totalNumstart+=numstart4*4
        totalAssign+=numstart4
        let numstart5 = data["numstart5"].int!
        totalNumstart+=numstart5*5
        totalAssign+=numstart5
        
        let alpha: CGFloat = 0.6
        let color1 = UIColor.init(hex: "#F78B5D").withAlphaComponent(alpha)
        let color2 = UIColor.init(hex: "#FCB232").withAlphaComponent(alpha)
        let color3 = UIColor.init(hex: "#FDD930").withAlphaComponent(alpha)
        let color4 = UIColor.init(hex: "#ADD137").withAlphaComponent(alpha)
        let color5 = UIColor.init(hex: "#A0C25A").withAlphaComponent(alpha)
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        let zero = ChartAxisValueDouble(0)
        if totalAssign == 0 {
            numberStartAVG.rating = 0
            lbNumberStar.text = "0.0 *"
            arrayChartBar = [
                ChartStackedBarModel(constant: ChartAxisValueString("1 sao", order: 1, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: 0, bgColor: color1)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("2 sao", order: 2, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: 0, bgColor: color2)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("3 sao", order: 3, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: 0, bgColor: color3)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("4 sao", order: 4, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: 0, bgColor: color4)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("5 sao", order: 5, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: 0, bgColor: color5)
                    ])
            ]
        }else{
            var avg:Double = Double(totalNumstart)/Double(totalAssign)
            avg = Double(round(avg*10)/10)
            numberStartAVG.rating = avg
            lbNumberStar.text = String(avg)+" *"
            arrayChartBar = [
                ChartStackedBarModel(constant: ChartAxisValueString("1 sao", order: 1, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: (Double(numstart1) / Double(totalAssign))*100, bgColor: color1)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("2 sao", order: 2, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: (Double(numstart2) / Double(totalAssign))*100, bgColor: color2)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("3 sao", order: 3, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: (Double(numstart3) / Double(totalAssign))*100, bgColor: color3)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("4 sao", order: 4, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: (Double(numstart4) / Double(totalAssign))*100, bgColor: color4)
                    ]),
                ChartStackedBarModel(constant: ChartAxisValueString("5 sao", order: 5, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: (Double(numstart5) / Double(totalAssign))*100, bgColor: color5)
                    ])
            ]
        }
        
        
        showChartView()
    }
    
    func showChartView(){
        showChart(horizontal: true)
        if let _ = chart {
            let sideSelector = DirSelector(frame: chartView.frame, controller: self)
            chartView.addSubview(sideSelector)
        }
    }
    
    fileprivate func chart(horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        let barModels = arrayChartBar
        let alpha: CGFloat = 0.6
        
        let (axisValues1, axisValues2) = (
            stride(from: 0, through: 100, by: 20).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString("", order: 0, labelSettings: labelSettings)] + barModels.map{$0.constant} + [ChartAxisValueString("", order: 6, labelSettings: labelSettings)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        
        let frame = chartView.frame
        let chartFrame = chart?.frame ?? CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - sideSelectorHeight)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let barViewSettings = ChartBarViewSettings(animDuration: 0.2)
        let chartStackedBarsLayer = ChartStackedBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, innerFrame: innerFrame, barModels: barModels, horizontal: horizontal, barWidth: 10, settings: barViewSettings, stackFrameSelectionViewUpdater: ChartViewSelectorAlpha(selectedAlpha: 1, deselectedAlpha: alpha)) {tappedBar in
            
            guard let stackFrameData = tappedBar.stackFrameData else {return}
            
            let chartViewPoint = tappedBar.layer.contentToGlobalCoordinates(CGPoint(x: tappedBar.barView.frame.midX, y: stackFrameData.stackedItemViewFrameRelativeToBarParent.minY))!
            let viewPoint = CGPoint(x: chartViewPoint.x, y: chartViewPoint.y + 70)
            let infoBubble = InfoBubble(point: viewPoint, preferredSize: CGSize(width: 50, height: 40), superview: self.chartView, text: "\(stackFrameData.stackedItemModel.quantity)", font: ExamplesDefaults.labelFont, textColor: UIColor.white, bgColor: UIColor.black)
            infoBubble.tapHandler = {
                infoBubble.removeFromSuperview()
            }
            self.chartView.addSubview(infoBubble)
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartStackedBarsLayer
            ]
        )
    }
    
    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = self.chart(horizontal: horizontal)
        self.chart = chart
        chart.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chart.view)
        
        let l1 = NSLayoutConstraint(item: chart.view, attribute: .leading, relatedBy: .equal, toItem: chartView, attribute: .leading, multiplier: 1, constant: 0)
        let l2 = NSLayoutConstraint(item: chart.view, attribute: .trailing, relatedBy: .equal, toItem: chartView, attribute: .trailing, multiplier: 1, constant: 0)
        let l3 = NSLayoutConstraint(item: chart.view, attribute: .bottom, relatedBy: .equal, toItem: chartView, attribute: .bottom, multiplier: 1, constant: 0)
        let l4 = NSLayoutConstraint(item: chart.view, attribute: .top, relatedBy: .equal, toItem: chartView, attribute: .top, multiplier: 1, constant: 0)
        view.addConstraints([l1, l2, l3, l4])
    }
    
    class DirSelector: UIView {
        
        //        let horizontal: UIButton
        //        let vertical: UIButton
        
        weak var controller: GTViewController?
        
        //        fileprivate let buttonDirs: [UIButton : Bool]
        
        init(frame: CGRect, controller: GTViewController) {
            
            self.controller = controller
            
            //            self.horizontal = UIButton()
            //            self.horizontal.setTitle("Horizontal", for: UIControlState())
            //            self.vertical = UIButton()
            //            self.vertical.setTitle("Vertical", for: UIControlState())
            //
            //            self.buttonDirs = [horizontal: true, vertical: false]
            
            super.init(frame: frame)
            
            //            addSubview(horizontal)
            //            addSubview(vertical)
            
            //            for button in [horizontal, vertical] {
            //                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
            //                button.setTitleColor(UIColor.blue, for: UIControlState())
            //                button.addTarget(self, action: #selector(DirSelector.buttonTapped(_:)), for: .touchUpInside)
            //            }
        }
        
        //        func buttonTapped(_ sender: UIButton) {
        //            let horizontal = sender == self.horizontal ? true : false
        //            controller?.showChart(horizontal: horizontal)
        //        }
        //
        //        override func didMoveToSuperview() {
        //            let views = [horizontal, vertical]
        //            for v in views {
        //                v.translatesAutoresizingMaskIntoConstraints = false
        //            }
        //
        //            let namedViews = views.enumerated().map{index, view in
        //                ("v\(index)", view)
        //            }
        //
        //            var viewsDict = Dictionary<String, UIView>()
        //            for namedView in namedViews {
        //                viewsDict[namedView.0] = namedView.1
        //            }
        //
        //            let buttonsSpace: CGFloat = Env.iPad ? 20 : 10
        //
        //            let hConstraintStr = namedViews.reduce("H:|") {str, tuple in
        //                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
        //            }
        //
        //            let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraints(withVisualFormat: "V:|[\($0.0)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)}
        //
        //            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraintStr, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)
        //                + vConstraits)
        //        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
extension GTViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUserAssignment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentTableViewCell", for: indexPath) as! AssignmentTableViewCell
        let url  = URL(string :self.geturl(url: listUserAssignment[indexPath.row]._avatar))
        cell.avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_vn"), options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        cell.avatar.layer.borderColor = UIColor(hex: AColor.whiteColor).cgColor
        cell.avatar.layer.borderWidth = 2.0
        cell.name.text = listUserAssignment[indexPath.row]._detailname
        cell.comment.text = listUserAssignment[indexPath.row]._contentcomment
        cell.numstart.rating = Double(listUserAssignment[indexPath.row]._numstart)
        if listUserAssignment[indexPath.row]._isattent == 1{
            cell.ic_shield.isHidden = false
            cell.isattent.text = "Đã đi tour"
        }else{
            cell.ic_shield.isHidden = true
            cell.isattent.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 125
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
                getListAssignment(page: currentPage)
            }else {
                print("the end")
            }
        }
    }
}
