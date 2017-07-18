//
//  Tour.swift
//  Tour
//
//  Created by tnt on 6/5/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tour : NSObject, NSCoding {
    private var idtour:Int!
    private var iduser:Int!
    private var name:String!
    private var timestart:Int64!
    private var timeend:Int64!
    private var createat:Int64!
    private var status:Int!
    private var reasonforcancellation:String!
    private var slogan:String!
    private var timetour:String!
    private var idprogram:String!
    private var numbervehicle:String!
    private var typevehicle:String!
    private var totalseat:Int!
    private var home:String!
    private var targetplace:String!
    private var beginplace:String!
    private var ispickup:Int!
    private var comment:String!
    private var imagetour:[String]!
    private var attachment:String!
    private var statustableview:Int!
    private var tourinfo:String!
    private var listimagestourinfor:String!
    private var totaluser:Int!
    private var infoprice:[InfoPrice]!
    private var tourProgram:[TourProgram]!
    private var schedules:[Schedule]!
    private var useroftours:[Useroftour]!
    private var restauranthoteltour:[Place]!
    private var hoteltour:[Place]!
    private var placetour:[Place]!
    private var tourrank:[TourRank]!
    private var user:User!
    
    var _idtour : Int! {
        get{
            return self.idtour
        }
        set(value) {
            self.idtour = value
        }
    }
    var _iduser : Int! {
        get{
            return self.iduser
        }
        set(value) {
            self.iduser = value
        }
    }
    var _name : String! {
        get{
            return self.name
        }
        set(value) {
            self.name = value
        }
    }
    var _timestart : Int64! {
        get{
            return self.timestart
        }
        set(value) {
            self.timestart = value
        }
    }
    var _timeend : Int64! {
        get{
            return self.timeend
        }
        set(value) {
            self.timeend = value
        }
    }
    var _createat : Int64! {
        get{
            return self.createat
        }
        set(value) {
            self.createat = value
        }
    }
    var _status : Int! {
        get{
            return self.status
        }
        set(value) {
            self.status = value
        }
    }
    var _reasonforcancellation : String! {
        get{
            return self.reasonforcancellation
        }
        set(value) {
            self.reasonforcancellation = value
        }
    }
    var _slogan : String! {
        get{
            return self.slogan
        }
        set(value) {
            self.slogan = value
        }
    }
    var _timetour : String! {
        get{
            return self.timetour
        }
        set(value) {
            self.timetour = value
        }
    }
    var _idprogram : String! {
        get{
            return self.idprogram
        }
        set(value) {
            self.idprogram = value
        }
    }
    var _numbervehicle : String! {
        get{
            return self.numbervehicle
        }
        set(value) {
            self.numbervehicle = value
        }
    }
    var _typevehicle : String! {
        get{
            return self.typevehicle
        }
        set(value) {
            self.typevehicle = value
        }
    }
    var _totalseat : Int! {
        get{
            return self.totalseat
        }
        set(value) {
            self.totalseat = value
        }
    }
    var _home : String! {
        get{
            return self.home
        }
        set(value) {
            self.home = value
        }
    }
    var _targetplace : String! {
        get{
            return self.targetplace
        }
        set(value) {
            self.targetplace = value
        }
    }
    var _beginplace : String! {
        get{
            return self.beginplace
        }
        set(value) {
            self.beginplace = value
        }
    }
    
    var _ispickup : Int! {
        get{
            return self.ispickup
        }
        set(value) {
            self.ispickup = value
        }
    }
    var _comment : String! {
        get{
            return self.comment
        }
        set(value) {
            self.comment = value
        }
    }
    var _imagetour : [String]! {
        get{
            return self.imagetour
        }
        set(value) {
            self.imagetour = value
        }
    }
    var _attachment : String! {
        get{
            return self.attachment
        }
        set(value) {
            self.attachment = value
        }
    }
    var _statustableview : Int! {
        get{
            return self.statustableview
        }
        set(value) {
            self.statustableview = value
        }
    }
    var _tourinfo : String! {
        get{
            return self.tourinfo
        }
        set(value) {
            self.tourinfo = value
        }
    }
    var _listimagestourinfor : String! {
        get{
            return self.listimagestourinfor
        }
        set(value) {
            self.listimagestourinfor = value
        }
    }
    
    var _totaluser : Int! {
        get{
            return self.totaluser
        }
        set(value) {
            self.totaluser = value
        }
    }
    var _infoprice : [InfoPrice]! {
        get{
            return self.infoprice
        }
        set(value) {
            self.infoprice = value
        }
    }
    var _tourProgram : [TourProgram]! {
        get{
            return self.tourProgram
        }
        set(value) {
            self.tourProgram = value
        }
    }
    var _schedules : [Schedule]! {
        get{
            return self.schedules
        }
        set(value) {
            self.schedules = value
        }
    }
    var _useroftours : [Useroftour]!{
        get{
            return self.useroftours
        }
        set(value) {
            self.useroftours = value
        }
    }
    var _restauranthoteltour:[Place]!{
        get{
            return self.restauranthoteltour
        }
        set(value){
            self.restauranthoteltour = value
        }
    }
    var _hoteltour:[Place]!{
        get{
            return self.hoteltour
        }
        set(value){
            self.hoteltour = value
        }
    }
    var _placetour:[Place]!{
        get{
            return self.placetour
        }
        set(value){
            self.placetour = value
        }
    }
    var _tourrank:[TourRank]!{
        get{
            return self.tourrank
        }
        set(value){
            self.tourrank = value
        }
    }
    var _user:User{
        get{
            return self.user
        }
        set(value){
            self.user = value
        }
    }
    
    override init(){
        idtour = 0
        iduser = 0
        name = ""
        timestart = 0
        timeend = 0
        createat = 0
        status = 0
        reasonforcancellation = ""
        slogan = ""
        timetour = ""
        idprogram = ""
        numbervehicle = ""
        typevehicle = ""
        totalseat = 0
        home = ""
        targetplace = ""
        beginplace = ""
        ispickup = 0
        comment = ""
        imagetour = [String]()
        attachment = ""
        statustableview = 0
        tourinfo = ""
        listimagestourinfor = ""
        totaluser = 0
        infoprice = [InfoPrice]()
        tourProgram = [TourProgram]()
        schedules = [Schedule]()
        useroftours = [Useroftour]()
        restauranthoteltour = [Place]()
        hoteltour = [Place]()
        placetour = [Place]()
        tourrank = [TourRank]()
        user = User()
    }
    init(idtour:Int, iduser:Int, name:String, timestart:Int64, timeend:Int64, createat:Int64, status:Int, reasonforcancellation:String, slogan:String, timetour:String, tourprice:Double, idprogram:String, numbervehicle:String, typevehicle:String, totalseat:Int, home:String, targetplace:String, beginplace:String, discountprice:Double, ispickup:Int, comment:String, childrentprice:Double, childrentdiscountprice:Double, imagetour:[String], attachment:String, tourinfo:String, listimagestourinfor:String, totaluser:Int, infoprice:[InfoPrice], tourProgram:[TourProgram], schedules:[Schedule], useroftours:[Useroftour], restauranthoteltour:[Place], hoteltour:[Place], placetour:[Place], tourrank:[TourRank], user:User){
        self.idtour = idtour
        self.iduser = iduser
        self.name = name
        self.timestart = timestart
        self.timeend = timeend
        self.createat = createat
        self.status = status
        self.reasonforcancellation = reasonforcancellation
        self.slogan = slogan
        self.timetour = timetour
        self.idprogram = idprogram
        self.numbervehicle = numbervehicle
        self.typevehicle = typevehicle
        self.totalseat = totalseat
        self.home = home
        self.targetplace = targetplace
        self.beginplace = beginplace
        self.ispickup = ispickup
        self.comment = comment
        self.imagetour = imagetour
        self.attachment = attachment
        self.statustableview = 0
        self.tourinfo = tourinfo
        self.listimagestourinfor = listimagestourinfor
        self.totaluser = totaluser
        self.infoprice = infoprice
        self.tourProgram = tourProgram
        self.schedules = schedules
        self.useroftours = useroftours
        self.restauranthoteltour = restauranthoteltour
        self.hoteltour = hoteltour
        self.placetour = placetour
        self.tourrank = tourrank
        self.user = user
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(idtour, forKey: "idtour")
        aCoder.encode(iduser, forKey: "iduser")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(timestart, forKey: "timestart")
        aCoder.encode(timeend, forKey: "timeend")
        aCoder.encode(createat, forKey: "createat")
        aCoder.encode(idtour, forKey: "idtour")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(reasonforcancellation, forKey: "reasonforcancellation")
        aCoder.encode(slogan, forKey: "slogan")
        aCoder.encode(timetour, forKey: "timetour")
        aCoder.encode(idprogram, forKey: "idprogram")
        aCoder.encode(numbervehicle, forKey: "numbervehicle")
        aCoder.encode(typevehicle, forKey: "typevehicle")
        aCoder.encode(totalseat, forKey: "idtour")
        aCoder.encode(home, forKey: "home")
        aCoder.encode(targetplace, forKey: "targetplace")
        aCoder.encode(beginplace, forKey: "beginplace")
        aCoder.encode(ispickup, forKey: "ispickup")
        aCoder.encode(comment, forKey: "comment")
        aCoder.encode(imagetour, forKey: "imagetour")
        aCoder.encode(attachment, forKey: "attachment")
        aCoder.encode(tourinfo, forKey: "tourinfo")
        aCoder.encode(listimagestourinfor, forKey: "listimagestourinfor")
        aCoder.encode(totaluser, forKey: "totaluser")
        aCoder.encode(infoprice, forKey: "infoprice")
        aCoder.encode(tourProgram, forKey: "tourProgram")
        aCoder.encode(schedules, forKey: "schedules")
        aCoder.encode(useroftours, forKey: "useroftours")
        aCoder.encode(restauranthoteltour, forKey: "restauranthoteltour")
        aCoder.encode(hoteltour, forKey: "hoteltour")
        aCoder.encode(placetour, forKey: "placetour")
        aCoder.encode(tourrank, forKey: "tourrank")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let idtour = aDecoder.decodeObject(forKey: "idtour") as! Int
        let iduser = aDecoder.decodeObject(forKey: "iduser") as! Int
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let timestart = aDecoder.decodeObject(forKey: "timestart") as! Int64
        let timeend = aDecoder.decodeObject(forKey: "timeend") as! Int64
        let createat = aDecoder.decodeObject(forKey: "createat") as! Int64
        let status = aDecoder.decodeObject(forKey: "status") as! Int
        let reasonforcancellation = aDecoder.decodeObject(forKey: "reasonforcancellation") as! String
        let slogan = aDecoder.decodeObject(forKey: "slogan") as! String
        let timetour = aDecoder.decodeObject(forKey: "timetour") as! String
        let tourprice = aDecoder.decodeObject(forKey: "tourprice") as! Double
        let idprogram = aDecoder.decodeObject(forKey: "idprogram") as! String
        let numbervehicle = aDecoder.decodeObject(forKey: "numbervehicle") as! String
        let typevehicle = aDecoder.decodeObject(forKey: "typevehicle") as! String
        let totalseat = aDecoder.decodeObject(forKey: "totalseat") as! Int
        let home = aDecoder.decodeObject(forKey: "home") as! String
        let targetplace = aDecoder.decodeObject(forKey: "targetplace") as! String
        let beginplace = aDecoder.decodeObject(forKey: "beginplace") as! String
        let discountprice = aDecoder.decodeObject(forKey: "discountprice") as! Double
        let ispickup = aDecoder.decodeObject(forKey: "ispickup") as! Int
        let comment = aDecoder.decodeObject(forKey: "comment") as! String
        let childrentprice = aDecoder.decodeObject(forKey: "childrentprice") as! Double
        let childrentdiscountprice = aDecoder.decodeObject(forKey: "childrentdiscountprice") as! Double
        let imagetour = aDecoder.decodeObject(forKey: "imagetour") as! [String]
        let attachment = aDecoder.decodeObject(forKey: "attachment") as! String
        let tourinfo = aDecoder.decodeObject(forKey: "tourinfo") as! String
        let listimagestourinfor = aDecoder.decodeObject(forKey: "listimagestourinfor") as! String
        let totaluser = aDecoder.decodeObject(forKey: "totaluser") as! Int
        let infoprice = aDecoder.decodeObject(forKey: "infoprice") as! [InfoPrice]
        let tourProgram = aDecoder.decodeObject(forKey: "tourProgram") as! [TourProgram]
        let schedules = aDecoder.decodeObject(forKey: "schedules") as! [Schedule]
        let useroftours = aDecoder.decodeObject(forKey: "useroftours") as! [Useroftour]
        let restauranthoteltour = aDecoder.decodeObject(forKey: "restauranthoteltour") as! [Place]
        let hoteltour = aDecoder.decodeObject(forKey: "hoteltour") as! [Place]
        let placetour = aDecoder.decodeObject(forKey: "placetour") as! [Place]
        let tourrank = aDecoder.decodeObject(forKey: "tourrank") as! [TourRank]
        let user = aDecoder.decodeObject(forKey: "user") as! User
        
        self.init(idtour: idtour, iduser: iduser, name: name, timestart: timestart, timeend: timeend, createat: createat, status: status, reasonforcancellation: reasonforcancellation, slogan: slogan, timetour: timetour, tourprice: tourprice, idprogram: idprogram, numbervehicle: numbervehicle, typevehicle: typevehicle, totalseat: totalseat, home: home, targetplace: targetplace, beginplace: beginplace, discountprice: discountprice, ispickup: ispickup, comment: comment, childrentprice: childrentprice, childrentdiscountprice: childrentdiscountprice, imagetour: imagetour, attachment: attachment, tourinfo: tourinfo, listimagestourinfor: listimagestourinfor, totaluser: totaluser, infoprice: infoprice, tourProgram: tourProgram, schedules:schedules, useroftours:useroftours, restauranthoteltour:restauranthoteltour, hoteltour:hoteltour, placetour:placetour, tourrank:tourrank, user:user)
    }
    
    static func parseJson(tourjson: JSON) -> Tour{
        let tour:Tour = Tour()
        if let idtour = tourjson["idtour"].int { tour._idtour = idtour }
        if let iduser = tourjson["iduser"].int { tour._iduser = iduser }
        if let name = tourjson["name"].string { tour._name = name }
        if let timestart = tourjson["timestart"].int64 { tour._timestart = timestart }
        if let timeend = tourjson["timeend"].int64 { tour._timeend = timeend }
        if let createat = tourjson["createat"].int64 { tour._createat = createat }
        if let status = tourjson["status"].int { tour._status = status }
        if let reasonforcancellation = tourjson["reasonforcancellation"].string { tour._reasonforcancellation = reasonforcancellation }
        if let slogan = tourjson["slogan"].string { tour._slogan = slogan }
        if let timetour = tourjson["timetour"].string { tour._timetour = timetour }
        if let idprogram = tourjson["idprogram"].string { tour._idprogram = idprogram }
        if let numbervehicle = tourjson["numbervehicle"].string { tour._numbervehicle = numbervehicle }
        if let typevehicle = tourjson["typevehicle"].string { tour._typevehicle = typevehicle }
        if let totalseat = tourjson["totalseat"].int { tour._totalseat = totalseat }
        if let home = tourjson["home"].string { tour._home = home }
        if let targetplace = tourjson["targetplace"].string { tour._targetplace = targetplace }
        if let beginplace = tourjson["beginplace"].string { tour._beginplace = beginplace }
        if let ispickup = tourjson["ispickup"].int { tour._ispickup = ispickup }
        if let comment = tourjson["comment"].string { tour._comment = comment }
        if let attachment = tourjson["attachment"].string { tour._attachment = attachment }
        if let tourinfo = tourjson["tourinfo"].string { tour._tourinfo = tourinfo }
        if let listimagestourinfor = tourjson["listimagestourinfor"].string { tour._listimagestourinfor = listimagestourinfor }
        if let totaluser = tourjson["totaluser"].int { tour._totaluser = totaluser }
        
        let imagetour:JSON = JSON(data: (tourjson["imagetour"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in 0 ..< imagetour.count {
            tour._imagetour.append(imagetour[i].string!)
        }
        
        let infoprice:JSON = JSON(data: (tourjson["infoprice"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        tour._infoprice = InfoPrice.parseArrayJson(infopricearrayjson: infoprice)
        if tourjson["tourprogram"].exists() {
            tour._tourProgram = TourProgram.parseJsonArray(jsonarray: tourjson["tourprogram"])
        }
        if tourjson["schedules"].exists() {
            tour._schedules = Schedule.parseArrayJson(arrayjson: tourjson["schedules"])
        }
        if tourjson["useroftours"].exists() {
            tour._useroftours = Useroftour.parseArrayJson(arrayjson: tourjson["useroftours"])
        }
        if tourjson["restauranthoteltour"].exists() {
            tour._restauranthoteltour = Place.parseArrayJson(arrayjson: tourjson["restauranthoteltour"])
        }
        if tourjson["hoteltour"].exists() {
            tour._hoteltour = Place.parseArrayJson(arrayjson: tourjson["hoteltour"])
        }
        if tourjson["placetour"].exists() {
            tour._placetour = Place.parseArrayJson(arrayjson: tourjson["placetour"])
        }
        if tourjson["tourrank"].exists() {
            tour._tourrank = TourRank.parseArrayJson(arrayjson: tourjson["tourrank"])
        }
        if tourjson["user"].exists() {
            tour._user = User.parseJson(userjson: tourjson["user"])
        }

        return tour
    }
    
    static func parseArrayJson(tourarrayjson: JSON) -> [Tour]{
        var tourarray:[Tour]=[Tour]()
        for i in 0...(tourarrayjson.count-1) {
            let tour:Tour = self.parseJson(tourjson: tourarrayjson[i])
            tourarray.append(tour)
        }
        return tourarray
    }
    
    func getIspickup() -> String{
        if self.ispickup == 0 { return "Tour trong nước" }
        return "Tour ngoài nước"
    }
    
    func getListAttachment() -> [String]{
        var list = self._attachment.characters.split{$0 == ","}.map(String.init)
        for i in 0 ..< list.count {
            if list[i] == "on" {
                list.remove(at: i)
            }
        }
        return list
    }
    func getListComment() -> [String] {
        return self._comment.characters.split{$0 == "\n"}.map(String.init)
    }
    func getListTypevehicle() -> [String] {
        return self._typevehicle.characters.split{$0 == ","}.map(String.init)
    }
    func getListHDV () -> [Useroftour] {
        var arr:[Useroftour] = [Useroftour]()
        
        for u in self._useroftours {
            if u._permission == 2 {
                arr.append(u)
            }
        }
        return arr
    }
}
