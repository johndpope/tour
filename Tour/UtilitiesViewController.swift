//
//  UtilitiesViewController.swift
//  Tour
//
//  Created by tnt on 6/2/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class UtilitiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var btnShowAndHideMenu: UIBarButtonItem!
    var listUtilities:[Utilities] = [Utilities]()
    var itemselect:Utilities = Utilities()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutButtonNav(btnShowAndHideMenu: btnShowAndHideMenu)
        listUtilities = [
            Utilities(link: "https://www.booking.com/index.vi.html", image: #imageLiteral(resourceName: "logo_booking"), label: "Tiện ích du lịch"),
            Utilities(link: "https://www.foody.vn/#/places", image: #imageLiteral(resourceName: "logo_foody"), label: "Địa điểm ăn uống"),
            Utilities(link: "https://www.abay.vn/", image: #imageLiteral(resourceName: "logo_abay"), label: "Đặt vé máy bay"),
            Utilities(link: "http://vnexpress.net/", image: #imageLiteral(resourceName: "logo_vnexpresss"), label: "VNExpress"),
            Utilities(link: "http://mp3.zing.vn/", image: #imageLiteral(resourceName: "logo_zinggmp3"), label: "MP3 Zing"),
            Utilities(link: "http://www.nhaccuatui.com/", image: #imageLiteral(resourceName: "logo_nhaccuatuii"), label: "Nhaccuatui"),
            Utilities(link: "https://www.youtube.com/?gl=VN", image: #imageLiteral(resourceName: "logo_youtube"), label: "Youtube"),
            Utilities(link: "https://www.google.com.vn/", image: #imageLiteral(resourceName: "logo_google"), label: "Google"),
            Utilities(link: "http://news.zing.vn/", image: #imageLiteral(resourceName: "logo_zing_new"), label: "Zing News"),
            Utilities(link: "http://me.zing.vn/", image: #imageLiteral(resourceName: "logo_zingme"), label: "Zing Me"),
            Utilities(link: "http://tuoitre.vn/", image: #imageLiteral(resourceName: "logo_tuoitre"), label: "Báo Tuổi trẻ"),
            Utilities(link: "http://thanhnien.vn/", image: #imageLiteral(resourceName: "logo_thanhnien"), label: "Báo Thanh niên"),
            Utilities(link: "http://www.baomoi.com/", image: #imageLiteral(resourceName: "logo_baomoi"), label: "Baomoi.com"),
            Utilities(link: "http://laodong.com.vn/", image: #imageLiteral(resourceName: "logo_laodong"), label: "Báo Lao Động"),
            Utilities(link: "http://bongdaplus.vn/", image: #imageLiteral(resourceName: "logo_bongda"), label: "Báo Thể Thao")
        ]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemselect = listUtilities[indexPath.row]
        self.performSegue(withIdentifier: "gotoWebFromUtilities", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWebFromUtilities" {
            if let destination = segue.destination as? WebUtilitiesViewController {
                destination.itemselect = self.itemselect
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UtilitiesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UtilitiesCollectionViewCell", for: indexPath) as! UtilitiesCollectionViewCell
        cell.imageUtilities.image = listUtilities[indexPath.row]._image
        cell.labelUtilities.text = listUtilities[indexPath.row]._label
        cell.labelUtilities.backgroundColor = UIColor(hex: AColor.mainColorBackground1)
        let shadowPath2 = UIBezierPath(rect: cell.viewcontent.bounds)
        cell.viewcontent.layer.masksToBounds = false
        cell.viewcontent.layer.shadowColor = UIColor.black.cgColor
        cell.viewcontent.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        cell.viewcontent.layer.shadowOpacity = 0.4
        cell.viewcontent.layer.shadowPath = shadowPath2.cgPath
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listUtilities.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
