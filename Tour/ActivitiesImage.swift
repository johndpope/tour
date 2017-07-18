//
//  ActivitiesImage.swift
//  Tour
//
//  Created by tnt on 7/8/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class ActivitiesImage : NSObject, NSCoding{
    private var timeactivity:String!
    private var id:Int!
    private var iduser:Int!
    private var createat:String!
    private var nameactivity:String!
    private var urlimages:[String]!
    var _timeactivity:String!{
        get{
            return self.timeactivity
        }
        set(value){
            self.timeactivity = value
        }
    }
    var _id:Int!{
        get{
            return self.id
        }
        set(value){
            self.id = value
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
    var _createat:String!{
        get{
            return self.createat
        }
        set(value){
            self.createat = value
        }
    }
    var _nameactivity:String!{
        get{
            return self.nameactivity
        }
        set(value){
            self.nameactivity = value
        }
    }
    var _urlimages:[String]!{
        get{
            return self.urlimages
        }
        set(value){
            self.urlimages = value
        }
    }
    override init(){
        timeactivity = ""
        id = 0
        iduser = 0
        createat = ""
        nameactivity = ""
        urlimages = [String]()
    }
    init(timeactivity:String, id:Int, iduser:Int, createat:String, nameactivity:String, urlimages:[String]){
        self.timeactivity = timeactivity
        self.id = id
        self.iduser = iduser
        self.createat = createat
        self.nameactivity = nameactivity
        self.urlimages = urlimages
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(timeactivity, forKey: "timeactivity")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(iduser, forKey: "iduser")
        aCoder.encode(createat, forKey: "createat")
        aCoder.encode(nameactivity, forKey: "nameactivity")
        aCoder.encode(urlimages, forKey: "urlimages")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let timeactivity = aDecoder.decodeObject(forKey: "timeactivity") as! String
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let iduser = aDecoder.decodeObject(forKey: "iduser") as! Int
        let createat = aDecoder.decodeObject(forKey: "createat") as! String
        let nameactivity = aDecoder.decodeObject(forKey: "nameactivity") as! String
        let urlimages = aDecoder.decodeObject(forKey: "urlimages") as! [String]
        self.init(timeactivity: timeactivity, id: id, iduser: iduser, createat: createat, nameactivity: nameactivity, urlimages: urlimages)
    }
    static func parseJson(jsonobject: JSON) -> ActivitiesImage{
        let obj:ActivitiesImage = ActivitiesImage()
        if let timeactivity = jsonobject["timeactivity"].string { obj._timeactivity = timeactivity }
        if let id = jsonobject["id"].int { obj._id = id }
        if let iduser = jsonobject["iduser"].int { obj._iduser = iduser }
        if let createat = jsonobject["createat"].string { obj._createat = createat }
        if let nameactivity = jsonobject["nameactivity"].string { obj._nameactivity = nameactivity }
//        if let urlimages = jsonobject["urlimages"].[string] { obj._urlimages = urlimages }
        
        let image:JSON = JSON(data: (jsonobject["urlimages"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in 0 ..< image.count {
            obj._urlimages.append(image[i].string!)
        }
        
        return obj
    }
    static func parseArrayJson(arrayjson: JSON) -> [ActivitiesImage]{
        var arrayobj:[ActivitiesImage]=[ActivitiesImage]()
        for i in 0...(arrayjson.count-1) {
            let obj:ActivitiesImage = self.parseJson(jsonobject: arrayjson[i])
            arrayobj.append(obj)
        }
        return arrayobj
    }
    static func parseArrayJson(stringdata: String) -> [ActivitiesImage]{
        let jarr:JSON = JSON(data: (stringdata as NSString).data(using: String.Encoding.utf8.rawValue)!)
        return self.parseArrayJson(arrayjson: jarr)
    }
}
