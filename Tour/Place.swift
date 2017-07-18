//
//  HotelTour.swift
//  Tour
//
//  Created by tnt on 6/26/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class Place : NSObject, NSCoding{
    private var id:Int!
    private var nameplace:String!
    private var address:String!
    private var phone:String!
    private var sofax:String!
    private var email:String!
    private var fanpage:String!
    private var website:String!
    private var activitytime:String!
    private var price:String!
    private var comment:String!
    private var lat:Double!
    private var lng:Double!
    private var listimages:[String]!
    private var specialservice:String!
    private var descript:String!
    private var listimagesdescript:String!
    private var iduser:Int!
    private var isshow:Bool!
    var _id:Int!{
        get{
            return self.id
        }
        set(value){
            self.id = value
        }
    }
    var _nameplace:String!{
        get{
            return self.nameplace
        }
        set(value){
            self.nameplace = value
        }
    }
    var _address:String!{
        get{
            return self.address
        }
        set(value){
            self.address = value
        }
    }
    var _phone:String!{
        get{
            return self.phone
        }
        set(value){
            self.phone = value
        }
    }
    var _sofax:String!{
        get{
            return self.sofax
        }
        set(value){
            self.sofax = value
        }
    }
    var _email:String!{
        get{
            return self.email
        }
        set(value){
            self.email = value
        }
    }
    var _fanpage:String!{
        get{
            return self.fanpage
        }
        set(value){
            self.fanpage = value
        }
    }
    var _website:String!{
        get{
            return self.website
        }
        set(value){
            self.website = value
        }
    }
    var _activitytime:String!{
        get{
            return self.activitytime
        }
        set(value){
            self.activitytime = value
        }
    }
    var _price:String!{
        get{
            return self.price
        }
        set(value){
            self.price = value
        }
    }
    var _comment:String!{
        get{
            return self.comment
        }
        set(value){
            self.comment = value
        }
    }
    var _lat:Double!{
        get{
            return self.lat
        }
        set(value){
            self.lat = value
        }
    }
    var _lng:Double!{
        get{
            return self.lng
        }
        set(value){
            self.lng = value
        }
    }
    var _listimages:[String]!{
        get{
            return self.listimages
        }
        set(value){
            self.listimages = value
        }
    }
    var _specialservice:String!{
        get{
            return self.specialservice
        }
        set(value){
            self.specialservice = value
        }
    }
    var _descript:String!{
        get{
            return self.descript
        }
        set(value){
            self.descript = value
        }
    }
    var _listimagesdescript:String!{
        get{
            return self.listimagesdescript
        }
        set(value){
            self.listimagesdescript = value
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
    var _isshow:Bool!{
        get{
            return self.isshow
        }
        set(value){
            self.isshow = value
        }
    }
    override init(){
        id = 0
        nameplace = ""
        address = ""
        phone = ""
        sofax = ""
        email = ""
        fanpage = ""
        website = ""
        activitytime = ""
        price = ""
        comment = ""
        lat = 0
        lng = 0
        listimages = [String]()
        specialservice = ""
        descript = ""
        listimagesdescript = ""
        iduser = 0
        isshow = false
    }
    init(id:Int, nameplace:String, address:String, phone:String, sofax:String, email:String, fanpage:String, website:String, activitytime:String, price:String, comment:String, lat:Double, lng:Double, listimages:[String], specialservice:String, descript:String, listimagesdescript:String, iduser:Int){
        self.id = id
        self.nameplace = nameplace
        self.address = address
        self.phone = phone
        self.sofax = sofax
        self.email = email
        self.fanpage = fanpage
        self.website = website
        self.activitytime = activitytime
        self.price = price
        self.comment = comment
        self.lat = lat
        self.lng = lng
        self.listimages = listimages
        self.specialservice = specialservice
        self.descript = descript
        self.listimagesdescript = listimagesdescript
        self.iduser = iduser
        self.isshow = false
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nameplace, forKey: "nameplace")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(sofax, forKey: "sofax")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(fanpage, forKey: "fanpage")
        aCoder.encode(website, forKey: "website")
        aCoder.encode(activitytime, forKey: "activitytime")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(comment, forKey: "comment")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        aCoder.encode(listimages, forKey: "listimages")
        aCoder.encode(specialservice, forKey: "specialservice")
        aCoder.encode(descript, forKey: "descript")
        aCoder.encode(listimagesdescript, forKey: "listimagesdescript")
        aCoder.encode(iduser, forKey: "iduser")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let nameplace = aDecoder.decodeObject(forKey: "nameplace") as! String
        let address = aDecoder.decodeObject(forKey: "address") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let sofax = aDecoder.decodeObject(forKey: "sofax") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let fanpage = aDecoder.decodeObject(forKey: "fanpage") as! String
        let website = aDecoder.decodeObject(forKey: "website") as! String
        let activitytime = aDecoder.decodeObject(forKey: "activitytime") as! String
        let price = aDecoder.decodeObject(forKey: "price") as! String
        let comment = aDecoder.decodeObject(forKey: "comment") as! String
        let lat = aDecoder.decodeObject(forKey: "lat") as! Double
        let lng = aDecoder.decodeObject(forKey: "lng") as! Double
        let listimages = aDecoder.decodeObject(forKey: "listimages") as! [String]
        let specialservice = aDecoder.decodeObject(forKey: "specialservice") as! String
        let descript = aDecoder.decodeObject(forKey: "descript") as! String
        let listimagesdescript = aDecoder.decodeObject(forKey: "listimagesdescript") as! String
        let iduser = aDecoder.decodeObject(forKey: "iduser") as! Int
        self.init(id: id, nameplace: nameplace, address: address, phone: phone, sofax: sofax, email: email, fanpage: fanpage, website: website, activitytime: activitytime, price: price, comment: comment, lat: lat, lng: lng, listimages: listimages, specialservice: specialservice, descript: descript, listimagesdescript: listimagesdescript, iduser: iduser)
    }
    static func parseJson(jsonobject: JSON) -> Place{
        let obj:Place = Place()
        if let id = jsonobject["id"].int { obj._id = id }
        if let nameplace = jsonobject["nameplace"].string { obj._nameplace = nameplace }
        if let address = jsonobject["address"].string { obj._address = address }
        if let phone = jsonobject["phone"].string { obj._phone = phone }
        if let sofax = jsonobject["sofax"].string { obj._sofax = sofax }
        if let email = jsonobject["email"].string { obj._email = email }
        if let fanpage = jsonobject["fanpage"].string { obj._fanpage = fanpage }
        if let website = jsonobject["website"].string { obj._website = website }
        if let activitytime = jsonobject["activitytime"].string { obj._activitytime = activitytime }
        if let price = jsonobject["price"].string { obj._price = price }
        if let comment = jsonobject["comment"].string { obj._comment = comment }
        if let lat = jsonobject["lat"].double { obj._lat = lat }
        if let lng = jsonobject["lng"].double { obj._lng = lng }
        if let specialservice = jsonobject["specialservice"].string { obj._specialservice = specialservice }
        if let descript = jsonobject["descript"].string { obj._descript = descript }
        if let listimagesdescript = jsonobject["listimagesdescript"].string { obj._listimagesdescript = listimagesdescript }
        if let iduser = jsonobject["iduser"].int { obj._iduser = iduser }
        
        let image:JSON = JSON(data: (jsonobject["listimages"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in 0 ..< image.count {
            obj._listimages.append(image[i].string!)
        }
        return obj
    }
    static func parseArrayJson(arrayjson: JSON) -> [Place]{
        var arrayobj:[Place]=[Place]()
        for i in 0 ..< arrayjson.count {
            let obj:Place = self.parseJson(jsonobject: arrayjson[i])
            var isExist:Bool = false
            for j in arrayobj{
                if j._id == obj._id{
                    isExist = true
                }
            }
            if !isExist {
                arrayobj.append(obj)
            }
        }
        return arrayobj
    }
    static func parseArrayJson(stringdata: String) -> [Place]{
        let jarr:JSON = JSON(data: (stringdata as NSString).data(using: String.Encoding.utf8.rawValue)!)
        return self.parseArrayJson(arrayjson: jarr)
    }
}
