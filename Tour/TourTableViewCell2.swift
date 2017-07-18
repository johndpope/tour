//    //
//    //  TourTableViewCell.swift
//    //  Tour
//    //
//    //  Created by tnt on 6/21/17.
//    //  Copyright © 2017 thangvnnc. All rights reserved.
//    //
//    
//    import UIKit
//    import Kingfisher
//    
//    class TourTableViewCell2: UITableViewCell {
//        
//        @IBOutlet weak var viewcontent: UIView!
//        @IBOutlet weak var slideShow: UIScrollView!
//        @IBOutlet weak var idtour: UILabel!
//        @IBOutlet weak var price: UILabel!
//        @IBOutlet weak var pricediscount: UILabel!
//        @IBOutlet weak var nametour: UILabel!
//        @IBOutlet weak var slogan: UILabel!
//        @IBOutlet weak var timestart: UILabel!
//        @IBOutlet weak var timeend: UILabel!
//        @IBOutlet weak var timetour: UILabel!
//        @IBOutlet weak var totalseat: UILabel!
//        @IBOutlet weak var ispickup: UILabel!
//        @IBOutlet weak var btnSchedule: GradientViewButton!
//        @IBOutlet weak var btnTourProgram: GradientViewButton!
//        @IBOutlet weak var btnDVKT: UIView!
//        @IBOutlet weak var btnDVKKT: UIView!
//        @IBOutlet weak var collectionViewDVKT: UICollectionView!
//        @IBOutlet weak var dvkkt: UILabel!
//        @IBOutlet weak var heightCollectionViewDVKT: NSLayoutConstraint!
//        @IBOutlet weak var heightViewDVKKT: NSLayoutConstraint!
//        @IBOutlet weak var lbBtnDVKT: UILabel!
//        @IBOutlet weak var lbBtnDVKKT: UILabel!
//        
//        @IBOutlet weak var tourCollectionViewVehicle: UICollectionView!
//        @IBOutlet weak var heightTableViewVehicle: NSLayoutConstraint!
//        
//        @IBOutlet weak var heightHDVTableView: NSLayoutConstraint!
//        
//        @IBOutlet weak var tableViewHDVTour: UITableView!
//       
//        
//        var tourdata:Tour = Tour()
//        
//        func shadowContentView(){
//            let shadowPath2 = UIBezierPath(rect: viewcontent.bounds)
//            viewcontent.layer.shadowColor = UIColor.black.cgColor
//            viewcontent.layer.shadowOpacity = 0.5
//            viewcontent.layer.shadowPath = shadowPath2.cgPath
//            viewcontent.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
//        }
//        
//        func setCollectionViewDataSourceDelegate
//            <D: UICollectionViewDataSource & UICollectionViewDelegate>
//            (dataSourceDelegate: D, forRow row: Int) {
//            let nib = UINib(nibName: "DVKTCollectionViewCell", bundle: nil)
//            self.shadowContentView()
//            
//            collectionViewDVKT.register(nib, forCellWithReuseIdentifier: "DVKTCollectionViewCell")
//            collectionViewDVKT.delegate = dataSourceDelegate
//            collectionViewDVKT.dataSource = dataSourceDelegate
//            collectionViewDVKT.tag = row
//            collectionViewDVKT.reloadData()
//        }
//        
//        override func awakeFromNib() {
//            super.awakeFromNib()
//            let nib = UINib(nibName: "DVKTCollectionViewCell", bundle: nil)
//            tourCollectionViewVehicle.register(nib, forCellWithReuseIdentifier: "DVKTCollectionViewCell")
//            let nib2 = UINib(nibName: "HDVTableViewCell", bundle: nil)
//            self.tableViewHDVTour.register(nib2, forCellReuseIdentifier: "HDVTableViewCell")
//            tableViewHDVTour.isScrollEnabled = false
//        }
//        
//        func dataTour (tour: Tour){
//            tourdata = tour
////            tourCollectionViewVehicle.reloadData()
////            tableViewHDVTour.reloadData()
//        }
//        func geturl(url:String) -> String {
//            return url.replacingOccurrences(of: "./", with: GetDataFromURL.URL_IMAGE)
//        }
//    }
//    
//    extension TourTableViewCell: UITableViewDataSource, UITableViewDelegate{
//        func showTableViewHDV() {
//            if tourdata.getListHDV().count > 0 {
//                tableViewHDVTour.reloadData()
//
//                var row = Double(tourdata.getListHDV().count) / 4.0
//                row.round(.awayFromZero)
//                heightHDVTableView.constant = CGFloat(132*row+21)
//            }
//        }
//        func hideTableViewHDV() {
//            heightHDVTableView.constant = CGFloat(0)
//        }
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return 1
//        }
//        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return tourdata.getListHDV().count
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell:HDVTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HDVTableViewCell", for: indexPath) as! HDVTableViewCell
//            let useroftours:[Useroftour] = tourdata.getListHDV()
//            
//            cell.name.text = useroftours[indexPath.row]._name
//            
//            let url  = URL(string :self.geturl(url: useroftours[indexPath.row]._avatar))
//            cell.avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_user"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
//            cell.avatar.layer.borderColor = UIColor.white.cgColor
//            cell.birthday.text = Date.init(milliseconds: useroftours[indexPath.row]._birthday).convertMilisecondsToDateString()
//            cell.numberphone.text = useroftours[indexPath.row]._phone
//            cell.addresslocation.text = "vi tri gg"
//            return cell
//        }
//        
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            tableViewHDVTour.estimatedRowHeight = 132
//            return UITableViewAutomaticDimension
//        }
//    }
//    
//    
//    
//    extension TourTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
//        func hideCollectionViewVehicle (){
//            heightTableViewVehicle.constant = CGFloat(0)
//        }
//        func showCollectionViewVehicle (){
//            tourCollectionViewVehicle.reloadData()
//            var row = Double(tourdata.getListTypevehicle().count) / 4.0
//            row.round(.awayFromZero)
//            heightTableViewVehicle.constant = CGFloat(125*row)
//        }
//        
//        func numberOfSections(in collectionView: UICollectionView) -> Int {
//            return 1
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return tourdata.getListTypevehicle().count
//        }
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            
//            let cell:DVKTCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DVKTCollectionViewCell", for: indexPath) as! DVKTCollectionViewCell
//            let name = tourdata.getListTypevehicle()[indexPath.row]
//            cell.name.text = name
//            cell.image.image = self.imageVehicle(name: name)
//            cell.viewcontent.layer.cornerRadius = 5
//            let shadowPath2 = UIBezierPath(rect: cell.viewcontent.bounds)
//            //        cell.viewcontent.layer.masksToBounds = false
//            cell.viewcontent.layer.shadowColor = UIColor.black.cgColor
//            cell.viewcontent.layer.shadowOpacity = 0.5
//            cell.viewcontent.layer.shadowPath = shadowPath2.cgPath
//            cell.viewcontent.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
//            
//            //        print(name)
//            //        print("&&&&&&&&&&&&&&&&&&&&&&")
//            return cell
//        }
//        func imageVehicle(name:String) -> UIImage {
//            var image:UIImage = UIImage()
//            switch name {
//            case "Xe ô tô":
//                image = #imageLiteral(resourceName: "ic_car")
//                break
//            case "Xe mô tô":
//                image = #imageLiteral(resourceName: "ic_motobike")
//                break
//            case "Xe giường nằm":
//                image = #imageLiteral(resourceName: "ic_bus")
//                break
//            case "Tàu cao tốc":
//                image = #imageLiteral(resourceName: "ic_high_speed_boat")
//                break
//            case "Du thuyền":
//                image = #imageLiteral(resourceName: "ic_yatch")
//                break
//            case "Cano":
//                image = #imageLiteral(resourceName: "ic_cano")
//                break
//            case "Máy bay":
//                image = #imageLiteral(resourceName: "ic_plane")
//                break
//            default:
//                break
//            }
//            return image
//        }
//    }
//    
