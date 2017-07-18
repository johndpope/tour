//
//  GMapSupport.swift
//  Tour
//
//  Created by tnt on 6/27/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import GoogleMaps
class GMapSupport {
   
    static func getAddress(lat: Double, lng: Double, completion:@escaping (_ address:String)->()){
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2DMake(lat, lng)) { response , error in
            var addressrs = "Không xác định"
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                addressrs = ""
                for i in lines {
                    addressrs += " "+i
                }
            }
            completion(addressrs)
        }
    }
}
