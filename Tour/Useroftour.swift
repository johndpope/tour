//
//  Useroftour.swift
//  Tour
//
//  Created by tnt on 6/25/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class Useroftour : NSObject, NSCoding{
    private var id:Int!
    private var idtour:Int!
    private var username:String!
    private var name:String!
    private var email:String!
    private var gender:Int!
    private var passport:String!
    private var phone:String!
    private var avatar:String!
    private var birthday:Int64!
    private var address:String!
    private var lat:Double!
    private var lng:Double!
    private var permission:Int!
    private var logged:Int!
    private var onofflocation:Int!
    private var lastlogin:Int64!
    var _id:Int!{
        get{
            return self.id
        }
        set(value){
            self.id = value
        }
    }
    var _idtour:Int!{
        get{
            return self.idtour
        }
        set(value){
            self.idtour = value
        }
    }
    var _username:String!{
        get{
            return self.username
        }
        set(value){
            self.username = value
        }
    }
    var _name:String!{
        get{
            return self.name
        }
        set(value){
            self.name = value
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
    var _gender:Int!{
        get{
            return self.gender
        }
        set(value){
            self.gender = value
        }
    }
    var _passport:String!{
        get{
            return self.passport
        }
        set(value){
            self.passport = value
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
    var _avatar:String!{
        get{
            return self.avatar
        }
        set(value){
            self.avatar = value
        }
    }
    var _birthday:Int64!{
        get{
            return self.birthday
        }
        set(value){
            self.birthday = value
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
    var _permission:Int!{
        get{
            return self.permission
        }
        set(value){
            self.permission = value
        }
    }
    var _logged:Int!{
        get{
            return self.logged
        }
        set(value){
            self.logged = value
        }
    }
    var _onofflocation:Int!{
        get{
            return self.onofflocation
        }
        set(value){
            self.onofflocation = value
        }
    }
    var _lastlogin:Int64!{
        get{
            return self.lastlogin
        }
        set(value){
            self.lastlogin = value
        }
    }
    override init(){
        id = 0
        idtour = 0
        username = ""
        name = ""
        email = ""
        gender = 0
        passport = ""
        phone = ""
        avatar = ""
        birthday = 0
        address = ""
        lat = 0
        lng = 0
        permission = 0
        logged = 0
        onofflocation = 0
        lastlogin = 0
    }
    init(id:Int, idtour:Int, username:String, name:String, email:String, gender:Int, passport:String, phone:String, avatar:String, birthday:Int64, address:String, lat:Double, lng:Double, permission:Int, logged:Int, onofflocation:Int, lastlogin:Int64){
        self.id = id
        self.idtour = idtour
        self.username = username
        self.name = name
        self.email = email
        self.gender = gender
        self.passport = passport
        self.phone = phone
        self.avatar = avatar
        self.birthday = birthday
        self.address = address
        self.lat = lat
        self.lng = lng
        self.permission = permission
        self.logged = logged
        self.onofflocation = onofflocation
        self.lastlogin = lastlogin
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(idtour, forKey: "idtour")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(passport, forKey: "passport")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        aCoder.encode(permission, forKey: "permission")
        aCoder.encode(logged, forKey: "logged")
        aCoder.encode(onofflocation, forKey: "onofflocation")
        aCoder.encode(lastlogin, forKey: "lastlogin")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let idtour = aDecoder.decodeObject(forKey: "idtour") as! Int
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let gender = aDecoder.decodeObject(forKey: "gender") as! Int
        let passport = aDecoder.decodeObject(forKey: "passport") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        let birthday = aDecoder.decodeObject(forKey: "birthday") as! Int64
        let address = aDecoder.decodeObject(forKey: "address") as! String
        let lat = aDecoder.decodeObject(forKey: "lat") as! Double
        let lng = aDecoder.decodeObject(forKey: "lng") as! Double
        let permission = aDecoder.decodeObject(forKey: "permission") as! Int
        let logged = aDecoder.decodeObject(forKey: "logged") as! Int
        let onofflocation = aDecoder.decodeObject(forKey: "onofflocation") as! Int
        let lastlogin = aDecoder.decodeObject(forKey: "lastlogin") as! Int64
        self.init(id: id, idtour: idtour, username: username, name: name, email: email, gender: gender, passport: passport, phone: phone, avatar: avatar, birthday: birthday, address: address, lat: lat, lng: lng, permission: permission, logged: logged, onofflocation: onofflocation, lastlogin: lastlogin)
    }
    static func parseJson(jsonobject: JSON) -> Useroftour{
        let obj:Useroftour = Useroftour()
        if let id = jsonobject["id"].int { obj._id = id }
        if let idtour = jsonobject["idtour"].int { obj._idtour = idtour }
        if let username = jsonobject["username"].string { obj._username = username }
        if let name = jsonobject["name"].string { obj._name = name }
        if let email = jsonobject["email"].string { obj._email = email }
        if let gender = jsonobject["gender"].int { obj._gender = gender }
        if let passport = jsonobject["passport"].string { obj._passport = passport }
        if let phone = jsonobject["phone"].string { obj._phone = phone }
        if let avatar = jsonobject["avatar"].string { obj._avatar = avatar }
        if let birthday = jsonobject["birthday"].int64 { obj._birthday = birthday }
        if let address = jsonobject["address"].string { obj._address = address }
        if let lat = jsonobject["lat"].double { obj._lat = lat }
        if let lng = jsonobject["lng"].double { obj._lng = lng }
        if let permission = jsonobject["permission"].int { obj._permission = permission }
        if let logged = jsonobject["logged"].int { obj._logged = logged }
        if let onofflocation = jsonobject["onofflocation"].int { obj._onofflocation = onofflocation }
        if let lastlogin = jsonobject["lastlogin"].int64 { obj._lastlogin = lastlogin }
        return obj
    }
    static func parseArrayJson(arrayjson: JSON) -> [Useroftour]{
        var arrayobj:[Useroftour]=[Useroftour]()
        for i in 0 ..< arrayjson.count{
            let obj:Useroftour = self.parseJson(jsonobject: arrayjson[i])
            arrayobj.append(obj)
        }
        return arrayobj
    }
    
    static func parseArrayJson(stringdata: String) -> [Useroftour]{
        let jarr:JSON = JSON(data: (stringdata as NSString).data(using: String.Encoding.utf8.rawValue)!)
        return self.parseArrayJson(arrayjson: jarr)
    }
    func getPermission() -> String{
        var permission:String = ""
        switch self._permission {
        case 0:
            permission = "Hành khách"
            break
        case 1:
            permission = "Tài xế"
            break
        case 2:
            permission = "Hướng dẫn viên"
            break
        case 3:
            permission = "Trưởng đoàn"
            break
        default:
            break
        }
        return permission
    }
}
