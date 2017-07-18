//
//  DetailInfoTourViewController.swift
//  Tour
//
//  Created by tnt on 6/20/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import Auk
import moa
class DetailInfoTourViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var pricediscountlabel: UILabel!
    
    
    @IBOutlet weak var slideShow: UIScrollView!
    @IBOutlet weak var idtour: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var timestart: UILabel!
    @IBOutlet weak var countdowntime: UILabel!
    
    @IBOutlet weak var numberseat: UILabel!
    @IBOutlet weak var beginstart: UILabel!
    @IBOutlet weak var btnDatTour: GradientView!
    
    @IBOutlet weak var lbBtnDVKT: UILabel!
    @IBOutlet weak var btnDVKT: UIView!
    @IBOutlet weak var colectionViewDVKT: UICollectionView!
    @IBOutlet weak var lbBtnDVKKT: UILabel!
    @IBOutlet weak var btnDVKKT: UIView!
    @IBOutlet weak var btnCTTour: GradientView!
    @IBOutlet weak var heightDVKT: NSLayoutConstraint!
    var heightDVKTDef:CGFloat = CGFloat(250)
    
    @IBOutlet weak var listDVKKT: UILabel!
    var listAttachment:[String]!
    var listTypeVehicle:[String]!
    
    @IBOutlet weak var heightDVKKT: NSLayoutConstraint!
    var heightDVKKTDef:CGFloat = CGFloat(21)
    
    @IBOutlet weak var btnInfoTour: GradientView!
    
    @IBOutlet weak var webviewtourinfo: UIWebView!
    @IBOutlet weak var heightwebviewinfotour: NSLayoutConstraint!
    
    
    @IBOutlet weak var tableViewTourProgram: UITableView!
    @IBOutlet weak var heightTourprogram: NSLayoutConstraint!
    var heightTBTourprogram:CGFloat = CGFloat(0)
    
    @IBOutlet weak var collectionViewVehicle: UICollectionView!
    @IBOutlet weak var heightCollectionViewVehicle: NSLayoutConstraint!
    var isShowTableVehicle:Bool = false
    
    @IBOutlet weak var heightInfoPrice: NSLayoutConstraint!
    @IBOutlet weak var tableViewInfoPrice: UITableView!
    
    var tourRec:Tour!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DVKTCollectionViewCell", bundle: nil)
        self.colectionViewDVKT.register(nib, forCellWithReuseIdentifier: "DVKTCollectionViewCell")
        let nib2 = UINib(nibName: "TourProgramTableViewCell", bundle: nil)
        self.tableViewTourProgram.register(nib2, forCellReuseIdentifier: "TourProgramTableViewCell")
        let nib3 = UINib(nibName: "HeaderInfoPriceTableViewCell", bundle: nil)
        self.tableViewInfoPrice.register(nib3, forCellReuseIdentifier: "HeaderInfoPriceTableViewCell")
        let nib4 = UINib(nibName: "BodyInfoPriceTableViewCell", bundle: nil)
        self.tableViewInfoPrice.register(nib4, forCellReuseIdentifier: "BodyInfoPriceTableViewCell")
        initLoad()
    }
    
    func initLoad(){
        
        let maxPrice:InfoPrice = InfoPrice.getMaxInfoPriceItem(arrayInfoPrice: tourRec._infoprice)
        
        let text = String(maxPrice._price)+" "+maxPrice._currency
        
        if ( maxPrice._price > maxPrice._pricediscount && maxPrice._pricediscount > 0){
            self.pricediscountlabel.text = String(maxPrice._pricediscount)+maxPrice._currency
            self.pricediscountlabel.isHidden = false
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName , value: 2, range: textRange)
            
            self.pricelabel.attributedText = attributedText
        }else{
            self.pricediscountlabel.isHidden = true
            self.pricelabel.text = text
        }
        
        let imagetour:[String] = tourRec._imagetour
        self.slideShow.auk.removeAll()
        for i in 0 ... (imagetour.count-1) {
            self.slideShow.auk.show(url: imagetour[i])
            self.slideShow.auk.settings.contentMode = .scaleToFill
        }
        self.slideShow.auk.startAutoScroll(delaySeconds: 4)
        self.idtour.text = String(tourRec._idtour)
        self.slogan.text = tourRec._name
        self.timestart.text = Date.init(milliseconds: tourRec._timestart).convertMilisecondsToDateString()
        self.countdowntime.text = Date.init(milliseconds: tourRec._timestart).offsetWithCurrentTime()
        self.beginstart.text = tourRec._beginplace
        self.numberseat.text = String(tourRec._totalseat - tourRec._totaluser)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(btnDVKT(_:)))
        self.btnDVKT.isUserInteractionEnabled = true
        self.btnDVKT.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(btnDVKKT(_:)))
        self.btnDVKKT.isUserInteractionEnabled = true
        self.btnDVKKT.addGestureRecognizer(tap2)
        
        listAttachment = tourRec.getListAttachment()
        self.btnDVKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
        
        var row = Double(listAttachment.count) / 4.0
        
        row.round(.awayFromZero)
        heightDVKTDef = CGFloat(125*row)
        heightDVKT.constant = heightDVKTDef
        
        let listComment = tourRec.getListComment()
        self.listDVKKT.text = self.tourRec._comment
        self.heightDVKKTDef = CGFloat(listComment.count*21)
        heightDVKKT.constant = 0
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(btnInfoTour(_:)))
        self.btnInfoTour.isUserInteractionEnabled = true
        self.btnInfoTour.addGestureRecognizer(tap3)
        
        self.webviewtourinfo.loadHTMLString(tourRec._tourinfo, baseURL: nil)
        self.heightwebviewinfotour.constant = CGFloat(0)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(btnDatTour(_:)))
        self.btnDatTour.isUserInteractionEnabled = true
        self.btnDatTour.addGestureRecognizer(tap4)
        
        //        print("-----------------------")
        //        print(tourRec._tourProgram.count)
        for item in tourRec._tourProgram {
            item._isShow = false
        }
        self.heightTBTourprogram = CGFloat(tourRec._tourProgram.count*45)
        self.heightTourprogram.constant = heightTBTourprogram
        listTypeVehicle = tourRec.getListTypevehicle()
        
        self.heightInfoPrice.constant = CGFloat(21*(tourRec._infoprice.count+1))
    }
    func btnDatTour (_ sender:UITapGestureRecognizer){
        //        if let view = sender.view {
        //            let backItem = UIBarButtonItem()
        //            backItem.title = tourSendDetail._name
        //            navigationItem.backBarButtonItem = backItem
        self.performSegue(withIdentifier: "gotoDatTourFromDetailInfo", sender: self)
        //        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "gotoDatTourFromDetailInfo":
            if let des = segue.destination as? DatTourViewController{
                des.tourRec = tourRec
            }
            break
        default:
            break
        }
    }
    
    func btnDVKT (_ sender:UITapGestureRecognizer){
        heightDVKT.constant = heightDVKTDef
        heightDVKKT.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.btnDVKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
            self.lbBtnDVKT.textColor = UIColor.white
            self.btnDVKKT.backgroundColor = UIColor.white
            self.lbBtnDVKKT.textColor = UIColor.black
            self.view.layoutIfNeeded()
            self.scrollView.scrollToView(view: self.btnDVKKT, animated: true)
        })
    }
    
    func btnDVKKT (_ sender:UITapGestureRecognizer){
        heightDVKKT.constant = self.heightDVKKTDef
        heightDVKT.constant = CGFloat(0)
        isShowTableVehicle = false
        self.heightCollectionViewVehicle.constant = CGFloat(0)
        UIView.animate(withDuration: 0.3, animations: {
            self.btnDVKT.backgroundColor = UIColor.white
            self.lbBtnDVKT.textColor = UIColor.black
            self.btnDVKKT.backgroundColor = UIColor.init(hex: AColor.mainColorBackground1)
            self.lbBtnDVKKT.textColor = UIColor.white
            self.view.layoutIfNeeded()
            self.scrollView.scrollToView(view: self.btnDVKKT, animated: true)
        })
    }
    
    func btnInfoTour (_ sender:UITapGestureRecognizer){
        if self.heightwebviewinfotour.constant > 0 {
            self.heightwebviewinfotour.constant = CGFloat(0)
        }else{
            self.heightwebviewinfotour.constant = CGFloat(400)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.scrollView.scrollToBottom()
        })
    }
}

extension DetailInfoTourViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.colectionViewDVKT:
            return listAttachment.count
        case collectionViewVehicle:
            return listTypeVehicle.count
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DVKTCollectionViewCell = colectionViewDVKT.dequeueReusableCell(withReuseIdentifier: "DVKTCollectionViewCell", for: indexPath) as! DVKTCollectionViewCell
        switch collectionView {
        case colectionViewDVKT:
            
            cell.name.text = listAttachment[indexPath.row]
            cell.image.image = self.imageDVKT(name: listAttachment[indexPath.row])
            
            return cell
        case collectionViewVehicle:
           
            let name = listTypeVehicle[indexPath.row]
            cell.name.text = name
            cell.image.image = self.imageVehicle(name: name)
            
            return cell
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView {
//        case self.colectionViewDVKT:
//            let cell:DVKTCollectionViewCell = collectionView.cellForItem(at: indexPath) as! DVKTCollectionViewCell
//            let nameItem = cell.name.text!
//            switch nameItem {
//            case "Xe đưa đón":
//                if isShowTableVehicle == true {
//                    self.heightCollectionViewVehicle.constant = CGFloat(0)
//                }else{
//                    var row = Double(tourRec.getListTypevehicle().count) / 4.0
//                    row.round(.awayFromZero)
//                    self.heightCollectionViewVehicle.constant = CGFloat(125*row)
//                }
//                isShowTableVehicle = !isShowTableVehicle
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.view.layoutIfNeeded()
//                    //                self.scrollView.scrollToView(view: self.btnDVKKT, animated: true)
//                })
//                break
//            default:
//                break
//            }
//        default:
//            break
//        }
    }
    func imageVehicle(name:String) -> UIImage {
        var image:UIImage = UIImage()
        switch name {
        case "Xe ô tô":
            image = #imageLiteral(resourceName: "ic_car")
            break
        case "Xe mô tô":
            image = #imageLiteral(resourceName: "ic_motobike")
            break
        case "Xe giường nằm":
            image = #imageLiteral(resourceName: "ic_bus")
            break
        case "Tàu cao tốc":
            image = #imageLiteral(resourceName: "ic_high_speed_boat")
            break
        case "Du thuyền":
            image = #imageLiteral(resourceName: "ic_yatch")
            break
        case "Cano":
            image = #imageLiteral(resourceName: "ic_cano")
            break
        case "Máy bay":
            image = #imageLiteral(resourceName: "ic_plane")
            break
        default:
            break
        }
        return image
    }
}



extension DetailInfoTourViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewTourProgram{
            return tourRec._tourProgram.count
        }else{
            return (tourRec._infoprice.count + 1)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewTourProgram{
            if tourRec._tourProgram[indexPath.row]._isShow == true {
                return (445)
            }
            return 45
        }else{
            return 21
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewTourProgram{
            
            let cell:TourProgramTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TourProgramTableViewCell", for: indexPath) as! TourProgramTableViewCell
            cell.date.text = tourRec._tourProgram[indexPath.row]._day
            if tourRec._tourProgram[indexPath.row]._isShow {
                cell.imagebtntourprogram.image = #imageLiteral(resourceName: "ic_arrow_down")
            }else{
                cell.imagebtntourprogram.image = #imageLiteral(resourceName: "ic_arrow_right")
            }
            cell.webViewTourProgram.loadHTMLString(tourRec._tourProgram[indexPath.row]._content, baseURL: nil)
            return cell
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderInfoPriceTableViewCell", for: indexPath) as! HeaderInfoPriceTableViewCell
                return cell
            }
            else{
                let index = indexPath.row - 1
                let cell = tableView.dequeueReusableCell(withIdentifier: "BodyInfoPriceTableViewCell", for: indexPath) as! BodyInfoPriceTableViewCell
                cell.type.text = tourRec._infoprice[index]._type
                cell.price.text = String(tourRec._infoprice[index]._price)+tourRec._infoprice[index]._currency
                cell.pricediscount.text = String(tourRec._infoprice[index]._pricediscount)+tourRec._infoprice[index]._currency
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewTourProgram{
            
            if tourRec._tourProgram[indexPath.row]._isShow {
                tourRec._tourProgram[indexPath.row]._isShow = !tourRec._tourProgram[indexPath.row]._isShow
                self.tableViewTourProgram.reloadData()
                self.heightTourprogram.constant = heightTBTourprogram
            }
            else{
                for item in tourRec._tourProgram {
                    item._isShow = false
                }
                tourRec._tourProgram[indexPath.row]._isShow = !tourRec._tourProgram[indexPath.row]._isShow
                self.heightTourprogram.constant = (400 + self.heightTBTourprogram)
            }
            let cell:TourProgramTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TourProgramTableViewCell", for: indexPath) as! TourProgramTableViewCell
            self.tableViewTourProgram.reloadData()
            self.scrollView.scrollToView(view: cell, animated: true)
        }
    }
    
    //    func showWebViewInfoTour(_ sender:UIGestureRecognizer){
    //        print("**********************")
    //        tourRec._tourProgram[sender.view!.tag]._isShow = true
    //        self.tableViewTourProgram.reloadData()
    //    }
}
