//
//  TourRank.swift
//  Tour
//
//  Created by tnt on 6/28/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class TourRank : NSObject, NSCoding{
    private var namecard:String!
    private var idrank:Int!
    private var signal:String!
    private var iduser:Int!
    private var imagerankcard:[String]!
    var _namecard:String!{
        get{
            return self.namecard
        }
        set(value){
            self.namecard = value
        }
    }
    var _idrank:Int!{
        get{
            return self.idrank
        }
        set(value){
            self.idrank = value
        }
    }
    var _signal:String!{
        get{
            return self.signal
        }
        set(value){
            self.signal = value
        }
    }
    var _iduser:Int!{
        get{
            return self.iduser
        }
        set(value){
            self.iduser = value
        }
    }
    var _imagerankcard:[String]!{
        get{
            return self.imagerankcard
        }
        set(value){
            self.imagerankcard = value
        }
    }
    override init(){
        namecard = ""
        idrank = 0
        signal = ""
        iduser = 0
        imagerankcard = [String]()
    }
    init(namecard:String, idrank:Int, signal:String, iduser:Int, imagerankcard:[String]){
        self.namecard = namecard
        self.idrank = idrank
        self.signal = signal
        self.iduser = iduser
        self.imagerankcard = imagerankcard
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(namecard, forKey: "namecard")
        aCoder.encode(idrank, forKey: "idrank")
        aCoder.encode(signal, forKey: "signal")
        aCoder.encode(iduser, forKey: "iduser")
        aCoder.encode(imagerankcard, forKey: "imagerankcard")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let namecard = aDecoder.decodeObject(forKey: "namecard") as! String
        let idrank = aDecoder.decodeObject(forKey: "idrank") as! Int
        let signal = aDecoder.decodeObject(forKey: "signal") as! String
        let iduser = aDecoder.decodeObject(forKey: "iduser") as! Int
        let imagerankcard = aDecoder.decodeObject(forKey: "imagerankcard") as! [String]
        self.init(namecard: namecard, idrank: idrank, signal: signal, iduser: iduser, imagerankcard: imagerankcard)
    }
    static func parseJson(jsonobject: JSON) -> TourRank{
        let obj:TourRank = TourRank()
        if let namecard = jsonobject["namecard"].string { obj._namecard = namecard }
        if let idrank = jsonobject["idrank"].int { obj._idrank = idrank }
        if let signal = jsonobject["signal"].string { obj._signal = signal }
        if let iduser = jsonobject["iduser"].int { obj._iduser = iduser }
        
        let image:JSON = JSON(data: (jsonobject["imagerankcard"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in 0 ..< image.count {
            obj._imagerankcard.append(image[i].string!)
        }
        return obj
    }
    static func parseArrayJson(arrayjson: JSON) -> [TourRank]{
        var arrayobj:[TourRank]=[TourRank]()
        for i in 0 ..< arrayjson.count {
            let obj:TourRank = self.parseJson(jsonobject: arrayjson[i])
            arrayobj.append(obj)
        }
        return arrayobj
    }
    static func parseArrayJson(stringdata: String) -> [TourRank]{
        let jarr:JSON = JSON(data: (stringdata as NSString).data(using: String.Encoding.utf8.rawValue)!)
        return self.parseArrayJson(arrayjson: jarr)
    }
}
