//
//  TourTableViewCell.swift
//  Tour
//
//  Created by tnt on 6/26/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Kingfisher
import moa
import Auk
class TourTableViewCell: UITableViewCell {
    @IBOutlet weak var slideShow: UIScrollView!
    @IBOutlet weak var idtour: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pricediscount: UILabel!
    @IBOutlet weak var nametour: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var timestart: 	UILabel!
    @IBOutlet weak var timeend: UILabel!
    @IBOutlet weak var timetour: UILabel!
    @IBOutlet weak var ispickup: UILabel!
    @IBOutlet weak var totalseat: UILabel!
    @IBOutlet weak var viewcontent: UIView!
    
    @IBOutlet weak var viewBtnShowDetailTour: UIView!
    
    @IBOutlet weak var collectionViewDVKT: UICollectionView!
    @IBOutlet weak var heightCollectionViewDVKT: NSLayoutConstraint!
    @IBOutlet weak var heightDVKKT: NSLayoutConstraint!
    var listAttachMent:[String] = [String]()
    
    @IBOutlet weak var collectionViewTourRank: UICollectionView!
    @IBOutlet weak var heightTourRank: NSLayoutConstraint!
    var listTourRank:[TourRank] = [TourRank]()
    
    @IBOutlet weak var collectionViewVehicle: UICollectionView!
    @IBOutlet weak var heightCollectionViewVehicle: NSLayoutConstraint!
    var listVehicle:[String] = [String]()
    
    @IBOutlet weak var tableViewHDV: UITableView!
    @IBOutlet weak var heightTableViewHDV: NSLayoutConstraint!
    var listHDV:[Useroftour] = [Useroftour]()
    
    @IBOutlet weak var tableViewPlace: UITableView!
    @IBOutlet weak var heightTableViewPlace: NSLayoutConstraint!
    var listPlace:[Place] = [Place]()
    
    @IBOutlet weak var btnDVKT: UIView!
    @IBOutlet weak var lbBtnDVKT: UILabel!
    
    @IBOutlet weak var btnDVKKT: UIView!
    @IBOutlet weak var lbBtnDVKKT: UILabel!
    
    @IBOutlet weak var btnTourProgram: GradientViewButton!
    @IBOutlet weak var btnSchedule: GradientViewButton!
    
    var tourdata:Tour = Tour()
    var tableViewParent:UITableView = UITableView()
    @IBOutlet weak var dvkkt: UILabel!
    override func draw(_ rect: CGRect) {
        initlayer(v: viewcontent)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewDVKT.isScrollEnabled = false
        let nib = UINib(nibName: "DVKTCollectionViewCell", bundle: nil)
        self.collectionViewDVKT.register(nib, forCellWithReuseIdentifier: "DVKTCollectionViewCell")
        self.collectionViewVehicle.register(nib, forCellWithReuseIdentifier: "DVKTCollectionViewCell")
        let nib2 = UINib(nibName: "HDVTableViewCell", bundle: nil)
        self.tableViewHDV.register(nib2, forCellReuseIdentifier: "HDVTableViewCell")
        let nib3 = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        self.tableViewPlace.register(nib3, forCellReuseIdentifier:"PlaceTableViewCell")
        let nib4 = UINib(nibName: "TourRankCollectionViewCell", bundle: nil)
        self.collectionViewTourRank.register(nib4, forCellWithReuseIdentifier:"TourRankCollectionViewCell")
    }
    
    func initData(tour: Tour, tableView: UITableView){
        tourdata = tour
        tableViewParent = tableView
    }
    
    func hideAll(){
        heightCollectionViewDVKT.constant = CGFloat(0)
        heightCollectionViewVehicle.constant = CGFloat(0)
        heightTableViewHDV.constant = CGFloat(0)
        heightTableViewPlace.constant = CGFloat(0)
    }
    func hideAllInsideDVKT(){
        heightCollectionViewVehicle.constant = CGFloat(0)
        heightTableViewHDV.constant = CGFloat(0)
        heightTableViewPlace.constant = CGFloat(0)
    }
}


extension TourTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func showDVKT(){
        listAttachMent = tourdata.getListAttachment()
        var row:Double = Double(listAttachMent.count) / 4.0
        row.round(.awayFromZero)
        self.heightCollectionViewDVKT.constant = CGFloat(125*row)
        self.collectionViewDVKT.reloadData()
    }
    func showTourRank(){
        listTourRank = tourdata._tourrank
        var row:Double = Double(listTourRank.count) / 2.0
        row.round(.awayFromZero)
        self.heightTourRank.constant = CGFloat(95*row)
        self.collectionViewTourRank.reloadData()
    }
    func showListVehicle(){
        listVehicle = tourdata.getListTypevehicle()
        var row:Double = Double(listVehicle.count) / 4.0
        row.round(.awayFromZero)
        self.heightCollectionViewVehicle.constant = CGFloat(125*row)
        self.collectionViewVehicle.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewDVKT:
            return listAttachMent.count
        case collectionViewVehicle:
            return listVehicle.count
        case collectionViewTourRank:
            return listTourRank.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case collectionViewDVKT:
            let cell:DVKTCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DVKTCollectionViewCell", for: indexPath) as! DVKTCollectionViewCell
            cell.name.text = listAttachMent[indexPath.row]
            cell.image.image = self.imageDVKT(name: listAttachMent[indexPath.row])
            return cell
        case collectionViewVehicle:
            let cell:DVKTCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DVKTCollectionViewCell", for: indexPath) as! DVKTCollectionViewCell
            cell.name.text = listVehicle[indexPath.row]
            cell.image.image = self.imageVehicle(name: listVehicle[indexPath.row])
            return cell
        case collectionViewTourRank:
            let cell:TourRankCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TourRankCollectionViewCell", for: indexPath) as! TourRankCollectionViewCell
            cell.signal.text = listTourRank[indexPath.row]._signal
            cell.namecard.text = listTourRank[indexPath.row]._namecard
            let image:[String] = listTourRank[indexPath.row]._imagerankcard
            cell.slideShow.auk.removeAll()
            for i in image {
                cell.slideShow.auk.show(url: i)
                cell.slideShow.auk.settings.contentMode = .scaleToFill
            }
            cell.slideShow.auk.startAutoScroll(delaySeconds: 4)
	
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch collectionView {
        case collectionViewDVKT:
            let cell:DVKTCollectionViewCell = collectionView.cellForItem(at: indexPath) as! DVKTCollectionViewCell
            tableViewParent.beginUpdates()
            hideAllInsideDVKT()
            let nameItem = cell.name.text!
            switch nameItem {
            case "Xe đưa đón":
                showListVehicle()
                break
            case "Hướng dẫn viên":
                showListHDV()
                break
            case "Bữa ăn theo chương trình":
                showListPlace(type: 1)
                break
            case "Nơi lưu trú":
                showListPlace(type: 0)
                break
            default:
                break
            }
            tableViewParent.endUpdates()
            break
            
        case collectionViewVehicle:
            break
        default:
            break
        }
        
    }
}

extension TourTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func showListHDV(){
        listHDV = tourdata.getListHDV()
        if listHDV.count > 0 {
            self.heightTableViewHDV.constant = CGFloat(1)
            self.tableViewHDV.reloadData()
        }
    }
    func showListPlace(type:Int){
        if type == 0{
            listPlace = tourdata._hoteltour
        }else{
            listPlace = tourdata._restauranthoteltour
        }
        if listPlace.count > 0 {
            self.heightTableViewPlace.constant = CGFloat(1)
            self.tableViewPlace.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewHDV{
            return listHDV.count
        }else{
            return listPlace.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewHDV{
            let cell:HDVTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HDVTableViewCell", for: indexPath) as! HDVTableViewCell
            let u:Useroftour = listHDV[indexPath.row]
            cell.name.text = u._name
            cell.numberphone.text = u._phone
            cell.birthday.text = Date(milliseconds: u._birthday).convertMilisecondsToDateString()
            let url  = URL(string :self.geturl(url: u._avatar))
            cell.avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_user"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
            
            cell.btnCall.isUserInteractionEnabled = true
            cell.btnCall.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(callPhone(_:)))
            cell.btnCall.addGestureRecognizer(tap)
            
            GMapSupport.getAddress(lat: u._lat, lng: u._lng) { (result) in
                self.tableViewHDV.beginUpdates()
                cell.addresslocation.text = result
                self.tableViewHDV.endUpdates()
                self.tableViewParent.beginUpdates()
                self.heightTableViewHDV.constant = self.tableViewHDV.contentSize.height
                self.tableViewParent.endUpdates()
            }
            
            return cell
        }else{
           
            let cell:PlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
            let place:Place = listPlace[indexPath.row]
            cell.price.text = place._price
            cell.time.text = place._activitytime
            cell.nameplace.text = place._nameplace
            cell.phone.text = place._phone
            cell.address.text = place._address
            let image:[String] = place._listimages
            cell.slideShow.auk.removeAll()
            for i in image {
                cell.slideShow.auk.show(url: i)
                cell.slideShow.auk.settings.contentMode = .scaleToFill
            }
            cell.slideShow.auk.startAutoScroll(delaySeconds: 4)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableViewPlace.beginUpdates()
                self.tableViewPlace.endUpdates()
                self.tableViewParent.beginUpdates()
                self.heightTableViewPlace.constant = self.tableViewPlace.contentSize.height
                self.tableViewParent.endUpdates()
            }
            return cell
        }
    }
    func callPhone(_ sender: UIGestureRecognizer){
        let useroftour = listHDV[sender.view!.tag]
        self.runCallPhoneNumber(number: useroftour._phone)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewHDV {
            return 132
        }else{
            return 292
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
