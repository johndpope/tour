//
//  MapViewController.swift
//  Tour
//
//  Created by tnt on 7/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import GoogleMaps
import Kingfisher

class MapViewController: FragmentViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapViewShow: UIView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    var infoWindow:InfoWindows!
    var mapView:GMSMapView!
    var frameMapView:CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setShowAnimate(type: self.animateDefault)
        
        infoWindow = Bundle.main.loadNibNamed("InfoWindows", owner: self, options: nil)?.first! as! InfoWindows
        
    }
    override func loadView() {
        super.loadView()
        listUseroftour = fetchListUseroftour(listUseroftour: tourRec._useroftours)
        
        guard let user = self.getDataSocketLocal(event: "logged") as? User else { return }
        let camera = GMSCameraPosition.camera(withLatitude: user._lat, longitude: user._lng, zoom: 14)
        let mapView = GMSMapView.map(withFrame: CGRect(x:0, y:0, width:frameMapView.width, height:frameMapView.height), camera: camera)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        self.mapView = mapView
        self.mapViewShow.addSubview(mapView)
        
        getListUseroftour { (listUseroftour) in
            print("list useroftour Map")
            self.listUseroftour = listUseroftour
            self.initMap(mapView: mapView)
        }
        
        self.registerDataSocketLocal(event: StringUserdefaults.textSearchUseroftour, selector: #selector(searchUseroftour))
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    func searchUseroftour (){
        if let stringsearch:String = self.getDataSocketLocal(event: StringUserdefaults.textSearchUseroftour) as? String {
            self.listUseroftour = self.searchListUseroftour(char: stringsearch, listUseroftour: listUseroftourbackup)
            self.mapView.clear()
            self.initMap(mapView: mapView)
        }
    }
    func initMap(mapView:GMSMapView){
        
        for i in 0 ..< listUseroftour.count {
            let useroftour = listUseroftour[i]
            let position = CLLocationCoordinate2D(latitude: useroftour._lat, longitude: useroftour._lng)
            let london = GMSMarker(position: position)
            //            london.title = useroftour._name
            let nib = UINib(nibName: "iconMap", bundle: nil)
            let view = nib.instantiate(withOwner: self, options: nil)[0] as! MarkerMap
            view.tag = i
            let url  = URL(string :self.geturl(url: useroftour._avatar))
            view.imageUser.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
            london.iconView = view
            london.map = mapView
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        infoWindow.removeFromSuperview()
        infoWindow = Bundle.main.loadNibNamed("InfoWindows", owner: self, options: nil)?.first! as! InfoWindows
        let view = marker.iconView as! MarkerMap
        let useroftour:Useroftour = listUseroftour[view.tag]
        GMapSupport.getAddress(lat: useroftour._lat, lng: useroftour._lng) { (addr) in
            self.address.text = "Địa chỉ: "+addr
            if let user = self.getDataSocketLocal(event: "logged") as? User{
                let kc = self.calculatorDistance(l1: CLLocationCoordinate2D(latitude: user._lat, longitude: user._lng), l2: marker.position)
                if kc > 1 {
                    self.distance.text = "Cách bạn: "+String(kc) + " km"
                }else{
                    self.distance.text = "Cách bạn: "+String(kc*1000) + " m"
                }
            }
        }
        print("click info useroftour:",useroftour._name)
        infoWindow.tag = view.tag
        infoWindow.name.text = useroftour._name
        let url  = URL(string : useroftour._avatar)
        infoWindow.image.kf.setImage(with: url, placeholder:#imageLiteral(resourceName: "logo"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        infoWindow.btnCall.tag = view.tag
        
        return infoWindow

    }
    
    func calculatorDistance(l1:CLLocationCoordinate2D, l2:CLLocationCoordinate2D) -> Double{
        return ( 6371 * acos( cos( radians(d: l1.latitude) ) * cos( radians( d: l2.latitude ) ) * cos( radians(d: l2.longitude ) - radians(d: l1.longitude) ) + sin( radians(d: l1.latitude) ) * sin( radians(d: l2.latitude ) ) ) )
    }
    
    func radians(d:Double) -> Double{
        return d.degtorad
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let useroftour = listUseroftour[infoWindow.tag]
        print(useroftour._phone)
        self.runCallPhoneNumber(number: useroftour._phone)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
        self.address.text = ""
        self.distance.text = ""
    }
}
