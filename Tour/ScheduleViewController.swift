//
//  ScheduleViewController.swift
//  Tour
//
//  Created by tnt on 6/24/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import SwiftyJSON
class ScheduleViewController: UIViewController {
    
    var tourRec:Tour!
    var listDateSchedule:[DateSchedule]!
    var listPlace:[Place] = [Place]()
    @IBOutlet weak var tableViewSchedule: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ScheduleTableViewCell", bundle: nil)
        tableViewSchedule.register(nib, forCellReuseIdentifier: "ScheduleTableViewCell")
        listDateSchedule = fetchDataDateSchedule(tour: tourRec)
//       self.tableViewSchedule.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
//    deinit {
//        self.tableViewSchedule.removeObserver(self, forKeyPath: "contentSize")
//    }
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print("content sizeeeeeeeeeeeeeeeeee")
//        
//    }
    
    
    func fetchDataDateSchedule(tour:Tour) -> [DateSchedule] {
        var dateschedules = [DateSchedule]()
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: Date.init(milliseconds: tour._timestart))
        let date2 = calendar.startOfDay(for: Date.init(milliseconds: tour._timeend))
        
        print(Date.init(milliseconds: tour._timestart).convertMilisecondsToDateString())
        print(Date.init(milliseconds: tour._timeend).convertMilisecondsToDateString())
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        var datestart:Int64 = date1.millisecondsSince1970
        if components.day! >= 1{
            let numberDate:Int = components.day! + 1
            for i in 1 ... numberDate {
                let dateschedule = DateSchedule()
                let stringdate = "Ngày "+String(i)
                dateschedule._namedate = stringdate
                let datestartday = datestart
                let dateendday = datestart + 86399000
                datestart = dateendday
                for itemschedule in tourRec._schedules {
                    if datestartday <= itemschedule._time && itemschedule._time <= dateendday {
                        dateschedule._schedules.append(itemschedule)
                    }
                }
                dateschedules.append(dateschedule)
            }
        }else{
            self.alert(message: "Không có lịch trình cho tour này")
        }
        return dateschedules
    }
    
}

class DateSchedule:NSObject, NSCoding{
    private var namedate:String!
    private var schedules:[Schedule]!
    private var isshow:Bool
    var _namedate:String!{
        get{
            return self.namedate
        }
        set(value){
            self.namedate = value
        }
    }
    var _schedules:[Schedule]!{
        get{
            return self.schedules
        }
        set(value){
            self.schedules = value
        }
    }
    var _isshow:Bool!{
        get{
            return self.isshow
        }
        set(value){
            self.isshow = value
        }
    }
    override init(){
        namedate = ""
        schedules = [Schedule]()
        isshow = false
    }
    required convenience init(coder aDecoder: NSCoder) {
        let namedate = aDecoder.decodeObject(forKey: "namedate") as! String
        let schedules = aDecoder.decodeObject(forKey: "schedules") as! [Schedule]
        self.init(namedate: namedate, schedules: schedules)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(namedate, forKey: "namedate")
        aCoder.encode(schedules, forKey: "schedules")
    }
    init(namedate:String, schedules:[Schedule]){
        self.namedate = namedate
        self.schedules = schedules
        self.isshow = false
    }
    
}

extension ScheduleViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDateSchedule.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        cell.namedate.text = listDateSchedule[indexPath.row]._namedate
        cell.btnShow.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(showTable(_:)))
        cell.btnShow.isUserInteractionEnabled = true
        cell.btnShow.addGestureRecognizer(tap)
        cell.viewController = self
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func showTable(_ sender: UIGestureRecognizer){
        let indexpath = IndexPath(row: sender.view!.tag, section: 0)
        let cell:ScheduleTableViewCell = self.tableViewSchedule.cellForRow(at: indexpath) as! ScheduleTableViewCell
        let dateSchedule:DateSchedule = listDateSchedule[indexpath.row]
        
        if dateSchedule._isshow == false{
            dateSchedule._isshow = true
            cell.imagebtn.image = #imageLiteral(resourceName: "ic_arrow_down")
            cell.initDataSchedule(listSchedule: dateSchedule._schedules, tableViewParent: self.tableViewSchedule, tourRec: tourRec)
            cell.show()
            tableViewSchedule.beginUpdates()
            cell.heightTableViewDetail1.constant = cell.tableViewDetail1.contentSize.height
            tableViewSchedule.endUpdates()
            initlayer(v: cell.contentview)
        }
        else{
            dateSchedule._isshow = false
            cell.imagebtn.image = #imageLiteral(resourceName: "ic_arrow_right")
            tableViewSchedule.beginUpdates()
            cell.heightTableViewDetail1.constant = CGFloat(1)
            tableViewSchedule.endUpdates()
            initlayer(v: cell.contentview)
        }
    }
}
