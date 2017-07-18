//
//  UITableCollection.swift
//  Tour
//
//  Created by tnt on 6/26/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
extension UIViewController{
    func imageDVKT(name:String) -> UIImage {
        var image:UIImage = UIImage()
        
        switch name {
        case "Quà tặng":
            image = #imageLiteral(resourceName: "ic_gift")
            break
        case "Nơi lưu trú":
            image = #imageLiteral(resourceName: "ic_hotel")
            break
        case "Xe đưa đón":
            image = #imageLiteral(resourceName: "ic_car_pickup")
            break
        case "Vé tham quan":
            image = #imageLiteral(resourceName: "ic_visit_ticket")
            break
        case "Hướng dẫn viên":
            image = #imageLiteral(resourceName: "ic_tour_guide")
            break
        case "Bữa ăn theo chương trình":
            image = #imageLiteral(resourceName: "ic_food")
            break
        case "Bảo hiểm":
            image = #imageLiteral(resourceName: "ic_insure")
            break
        default:
            break
        }
        return image
    }
    func initlayer(v:UIView){
        v.layer.cornerRadius = 5
        let shadowPath2 = UIBezierPath(rect: v.bounds)
        v.layer.shadowColor = UIColor.black.cgColor
        //        v.layer.shadowOpacity = 0.5
        v.layer.shadowPath = shadowPath2.cgPath
        v.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
    }
}

extension UICollectionViewCell {
    func initlayer(v:UIView){
        v.layer.cornerRadius = 5
        let shadowPath2 = UIBezierPath(rect: v.bounds)
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowPath = shadowPath2.cgPath
        v.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
    }
    func imageDVKT(name:String) -> UIImage {
        var image:UIImage = UIImage()
        
        switch name {
        case "Quà tặng":
            image = #imageLiteral(resourceName: "ic_gift")
            break
        case "Nơi lưu trú":
            image = #imageLiteral(resourceName: "ic_hotel")
            break
        case "Xe đưa đón":
            image = #imageLiteral(resourceName: "ic_car_pickup")
            break
        case "Vé tham quan":
            image = #imageLiteral(resourceName: "ic_visit_ticket")
            break
        case "Hướng dẫn viên":
            image = #imageLiteral(resourceName: "ic_tour_guide")
            break
        case "Bữa ăn theo chương trình":
            image = #imageLiteral(resourceName: "ic_food")
            break
        case "Bảo hiểm":
            image = #imageLiteral(resourceName: "ic_insure")
            break
        default:
            break
        }
        return image
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
    func emitDataSocketLocal(event:String, data: AnyObject){
        let keyUserDefaultLocalSocket:String = "keyLocalDataSocket" + event
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(encodedData, forKey: keyUserDefaultLocalSocket)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: event), object: nil)
    }
    func emitDataSocketLocal(event:String){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: event), object: nil)
    }
    func registerDataSocketLocal(event:String, selector:Selector){
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: event), object: nil)
    }
}

extension UITableViewCell {
    func initlayer(v:UIView){
        v.layer.cornerRadius = 5
        let shadowPath2 = UIBezierPath(rect: v.bounds)
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowPath = shadowPath2.cgPath
        v.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
    }
    func imageDVKT(name:String) -> UIImage {
        var image:UIImage = UIImage()
        
        switch name {
        case "Quà tặng":
            image = #imageLiteral(resourceName: "ic_gift")
            break
        case "Nơi lưu trú":
            image = #imageLiteral(resourceName: "ic_hotel")
            break
        case "Xe đưa đón":
            image = #imageLiteral(resourceName: "ic_car_pickup")
            break
        case "Vé tham quan":
            image = #imageLiteral(resourceName: "ic_visit_ticket")
            break
        case "Hướng dẫn viên":
            image = #imageLiteral(resourceName: "ic_tour_guide")
            break
        case "Bữa ăn theo chương trình":
            image = #imageLiteral(resourceName: "ic_food")
            break
        case "Bảo hiểm":
            image = #imageLiteral(resourceName: "ic_insure")
            break
        default:
            break
        }
        return image
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
    func geturl(url:String) -> String {
        return url.replacingOccurrences(of: "./", with: GetDataFromURL.URL_IMAGE)
    }
    func emitDataSocketLocal(event:String, data: AnyObject){
        let keyUserDefaultLocalSocket:String = "keyLocalDataSocket" + event
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(encodedData, forKey: keyUserDefaultLocalSocket)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: event), object: nil)
    }
    func emitDataSocketLocal(event:String){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: event), object: nil)
    }
    func registerDataSocketLocal(event:String, selector:Selector){
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: event), object: nil)
    }
    func runCallPhoneNumber(number:String){
        print("call sdt: \(number)")
        if number == ""{
            return
        }
        if let phoneurl:NSURL = NSURL(string:"tel://\(number)"){
            let app:UIApplication = UIApplication.shared
            if app.canOpenURL(phoneurl as URL){
                app.open(phoneurl as URL, options: [:], completionHandler: nil)
            }
        }
    }
}
