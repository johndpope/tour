//
//  Schedule.swift
//  Tour
//
//  Created by tnt on 6/21/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Schedule : NSObject, NSCoding{
    private var idtour:Int!
    private var content:String!
    private var time:Int64!
    private var idhotel:[Int]!
    private var idplace:[Int]!
    private var idrestaurant:[Int]!
    private var setbefore:Int64!
    private var createat:Int64!
    var _idtour:Int!{
        get{
            return self.idtour
        }
        set(value){
            self.idtour = value
        }
    }
    var _content:String!{
        get{
            return self.content
        }
        set(value){
            self.content = value
        }
    }
    var _time:Int64!{
        get{
            return self.time
        }
        set(value){
            self.time = value
        }
    }
    var _idhotel:[Int]!{
        get{
            return self.idhotel
        }
        set(value){
            self.idhotel = value
        }
    }
    var _idplace:[Int]!{
        get{
            return self.idplace
        }
        set(value){
            self.idplace = value
        }
    }
    var _idrestaurant:[Int]!{
        get{
            return self.idrestaurant
        }
        set(value){
            self.idrestaurant = value
        }
    }
    var _setbefore:Int64!{
        get{
            return self.setbefore
        }
        set(value){
            self.setbefore = value
        }
    }
    var _createat:Int64!{
        get{
            return self.createat
        }
        set(value){
            self.createat = value
        }
    }
    override init(){
        idtour = 0
        content = ""
        time = 0
        idhotel = [Int]()
        idplace = [Int]()
        idrestaurant = [Int]()
        setbefore = 0
        createat = 0
    }
    init(idtour:Int, content:String, time:Int64, idhotel:[Int], idplace:[Int], idrestaurant:[Int], setbefore:Int64, createat:Int64){
        self.idtour = idtour
        self.content = content
        self.time = time
        self.idhotel = idhotel
        self.idplace = idplace
        self.idrestaurant = idrestaurant
        self.setbefore = setbefore
        self.createat = createat
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(idtour, forKey: "idtour")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(idhotel, forKey: "idhotel")
        aCoder.encode(idplace, forKey: "idplace")
        aCoder.encode(idrestaurant, forKey: "idrestaurant")
        aCoder.encode(setbefore, forKey: "setbefore")
        aCoder.encode(createat, forKey: "createat")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let idtour = aDecoder.decodeObject(forKey: "idtour") as! Int
        let content = aDecoder.decodeObject(forKey: "content") as! String
        let time = aDecoder.decodeObject(forKey: "time") as! Int64
        let idhotel = aDecoder.decodeObject(forKey: "idhotel") as! [Int]
        let idplace = aDecoder.decodeObject(forKey: "idplace") as! [Int]
        let idrestaurant = aDecoder.decodeObject(forKey: "idrestaurant") as! [Int]
        let setbefore = aDecoder.decodeObject(forKey: "setbefore") as! Int64
        let createat = aDecoder.decodeObject(forKey: "createat") as! Int64
        self.init(idtour: idtour, content: content, time: time, idhotel: idhotel, idplace: idplace, idrestaurant: idrestaurant, setbefore: setbefore, createat: createat)
    }
    static func parseJson(jsonobject: JSON) -> Schedule{
        let obj:Schedule = Schedule()
        if let idtour = jsonobject["idtour"].int { obj._idtour = idtour }
        if let content = jsonobject["content"].string { obj._content = content }
        if let time = jsonobject["time"].int64 { obj._time = time }
        
        
        let jsonarr1:JSON = JSON(data: (jsonobject["idhotel"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
       
        for i in jsonarr1.arrayValue{
            obj._idhotel.append(i.int!)
        }
        
        let jsonarr2:JSON = JSON(data: (jsonobject["idplace"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in jsonarr2.arrayValue{
            obj._idplace.append(i.int!)
        }
        
        let jsonarr3:JSON = JSON(data: (jsonobject["idrestaurant"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in jsonarr3.arrayValue{
            obj._idrestaurant.append(i.int!)
        }

        if let setbefore = jsonobject["setbefore"].int64 { obj._setbefore = setbefore }
        if let createat = jsonobject["createat"].int64 { obj._createat = createat }
        return obj
    }
    static func parseArrayJson(arrayjson: JSON) -> [Schedule]{
        var arrayobj:[Schedule]=[Schedule]()
        for i in 0 ..< arrayjson.count {
            //            print(arrayjson[i])
            let obj:Schedule = self.parseJson(jsonobject: arrayjson[i])
            arrayobj.append(obj)
        }
        return arrayobj
    }
}
