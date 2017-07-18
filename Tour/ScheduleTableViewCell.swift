//
//  ScheduleTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/24/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var namedate: UILabel!
    @IBOutlet weak var btnShow: GradientViewButton!
    @IBOutlet weak var imagebtn: UIImageView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var tableViewDetail1: UITableView!
    @IBOutlet weak var heightTableViewDetail1: NSLayoutConstraint!
    var viewController:UIViewController!
    var tableViewParent:UITableView = UITableView()
    var listSchedule:[Schedule] = [Schedule]()
    var tourRec:Tour!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initlayer(v: contentview)
        let nib = UINib(nibName: "SchedulesDetail1TableViewCell", bundle: nil)
        tableViewDetail1.register(nib, forCellReuseIdentifier: "SchedulesDetail1TableViewCell")
    }
    func show(){
        tableViewDetail1.reloadData()
    }
    func initDataSchedule(listSchedule:[Schedule], tableViewParent:UITableView, tourRec:Tour){
        self.listSchedule = listSchedule.sorted(by: { $0._time < $1._time })
        self.tableViewParent = tableViewParent
        self.tourRec = tourRec
    }
    
    func fetchPlaceInDateSchedules(schedule:Schedule) -> [Place]{
        var places:[Place] = [Place]()
        for i in schedule._idhotel{
            if let place = fetchGetPlaces(id: i, places: tourRec._hoteltour) as? Place {
                places.append(place)
            }
        }
        for i in schedule._idrestaurant{
            if let place = fetchGetPlaces(id: i, places: tourRec._restauranthoteltour) as? Place {
                places.append(place)
            }
        }
        for i in schedule._idplace{
            if let place = fetchGetPlaces(id: i, places: tourRec._placetour) as? Place {
                places.append(place)
            }
        }
        return places
    }
    
    func fetchGetPlaces(id:Int, places:[Place]) -> Any{
        var place:Place!
        for p in places {
            if p._id == id{
                place = p
                break
            }
        }
        return place
    }
}

//class ListSchedule{
//    private var listPlace:[Place]!
//    private var isshow:Bool
//    
//    var _listPlace:[Place]!{
//        get{
//            return self.listPlace
//        }
//        set(value){
//            self.listPlace = value
//        }
//    }
//    var _isshow:Bool!{
//        get{
//            return self.isshow
//        }
//        set(value){
//            self.isshow = value
//        }
//    }
//    init(){
//        listPlace = [Place]()
//        isshow = false
//    }
//   
//    init(listPlace:[Place]){
//        self.listPlace = listPlace
//        self.isshow = false
//    }
//}

extension ScheduleTableViewCell:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSchedule.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchedulesDetail1TableViewCell", for: indexPath) as! SchedulesDetail1TableViewCell
        cell.time.text = Date.init(milliseconds: listSchedule[indexPath.row]._time).convertTimeString()
        cell.event.text = listSchedule[indexPath.row]._content
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickShow(_:)))
        cell.viewTop.isUserInteractionEnabled = true
        cell.viewTop.tag = indexPath.row
        cell.viewTop.addGestureRecognizer(tap)
        
        return cell
    }
    func clickShow(_ sender:UIGestureRecognizer){
        
        let fragmentPlace = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupPlaceTourViewController") as! PopupPlaceTourViewController
        
        fragmentPlace.listPlace = fetchPlaceInDateSchedules(schedule: listSchedule[sender.view!.tag])
        self.viewController.addChildViewController(fragmentPlace)
        fragmentPlace.view.frame = self.viewController.view.frame
        self.viewController.view.addSubview(fragmentPlace.view)
        fragmentPlace.didMove(toParentViewController: self.viewController)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
