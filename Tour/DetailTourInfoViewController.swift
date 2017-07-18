//
//  DetailTourInfoViewController.swift
//  Tour
//
//  Created by tnt on 7/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTourInfoViewController: FragmentViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nametour: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var idtour: UILabel!
    @IBOutlet weak var timetour: UILabel!
    @IBOutlet weak var timestart: UILabel!
    @IBOutlet weak var timeend: UILabel!
    @IBOutlet weak var totalseat: UILabel!
    @IBOutlet weak var ispickup: UILabel!
    @IBOutlet weak var viewcontentinfo: UIView!
    
    
    @IBOutlet weak var avataradmin: UIImageViewAvatar!
    @IBOutlet weak var nameadmin: UILabel!
    @IBOutlet weak var onlineoffline: UIImageView!
    @IBOutlet weak var viewcontentadmin: UIView!
    
    
    @IBOutlet weak var heightTableViewMember: NSLayoutConstraint!
    @IBOutlet weak var tableViewMember: UITableView!
    @IBOutlet weak var viewcontentlistmember: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setShowAnimate(type: self.animateDefault)
        
        let nib = UINib(nibName: "UseroftourTableViewCell", bundle: nil)
        tableViewMember.register(nib, forCellReuseIdentifier: "UseroftourTableViewCell")
        listUseroftour = fetchListUseroftour(listUseroftour: tourRec._useroftours)
        initInfoTour()
        initInfoAdmin()
        self.tableViewMember.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        getListUseroftour { (listUseroftour) in
            print("list useroftour Detail")
            self.listUseroftour = listUseroftour
            self.tableViewMember.reloadData()
        }
        
        self.registerDataSocketLocal(event: StringUserdefaults.textSearchUseroftour, selector: #selector(searchUseroftour))
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    func searchUseroftour (){
        if let stringsearch:String = self.getDataSocketLocal(event: StringUserdefaults.textSearchUseroftour) as? String {
            self.listUseroftour = self.searchListUseroftour(char: stringsearch, listUseroftour: listUseroftourbackup)
            self.tableViewMember.reloadData()
            scrollView.scrollToView(view: self.tableViewMember, animated: true)
        }
    }
    
    deinit {
        self.tableViewMember.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableViewMember.layer.removeAllAnimations()
        heightTableViewMember.constant = tableViewMember.contentSize.height
    }
    func initInfoTour(){
        nametour.text = tourRec._name
        slogan.text = tourRec._slogan
        idtour.text = String(tourRec._idtour)
        timetour.text = tourRec._timetour
        timestart.text = Date.init(milliseconds: tourRec._timestart).convertMilisecondsToDateString()
        timeend.text = Date.init(milliseconds: tourRec._timeend).convertMilisecondsToDateString()
        totalseat.text = String(tourRec._totalseat)
        ispickup.text = tourRec.getIspickup()
        initLayerView(v: viewcontentinfo)
    }
    func initInfoAdmin(){
        nameadmin.text = tourRec._user._detailname
        let url  = URL(string :self.geturl(url: tourRec._user._avatar))
        avataradmin.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_user"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        initLayerView(v: viewcontentadmin)
    }
    
}

extension DetailTourInfoViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUseroftour.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UseroftourTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UseroftourTableViewCell", for: indexPath) as! UseroftourTableViewCell
        cell.permission.text = listUseroftour[indexPath.row].getPermission()
        cell.birthday.text = Date.init(milliseconds: listUseroftour[indexPath.row]._birthday).convertMilisecondsToDateString()
        cell.name.text = listUseroftour[indexPath.row]._name
        cell.numberphone.text = listUseroftour[indexPath.row]._phone
        let url  = URL(string :self.geturl(url: listUseroftour[indexPath.row]._avatar))
        cell.avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_user"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        GMapSupport.getAddress(lat: listUseroftour[indexPath.row]._lat, lng: listUseroftour[indexPath.row]._lng) { (result) in
            tableView.beginUpdates()
            cell.addresslocation.text = result
            tableView.endUpdates()
            self.initlayer(v: cell.viewcontent)
        }
        cell.btnCall.isUserInteractionEnabled = true
        cell.btnCall.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(callPhone(_:)))
        cell.btnCall.addGestureRecognizer(tap)
        return cell
    }
    func callPhone(_ sender:UIGestureRecognizer){
        let useroftour = listUseroftour[sender.view!.tag]
        self.runCallPhoneNumber(number: useroftour._phone)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
