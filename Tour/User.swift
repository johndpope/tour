import Foundation
import SwiftyJSON
class User : NSObject, NSCoding {
    private var iduser:Int!
    private var username:String!
    private var password:String!
    private var phone:String!
    private var phonecompany:String!
    private var hotline:String!
    private var birthday:String!
    private var passport:String!
    private var identity_card:String!
    private var address:String!
    private var email:String!
    private var lat:Double!
    private var lng:Double!
    private var detailname:String!
    private var gender:Int!
    private var avatar:String!
    private var logocompany:String!
    private var lock:Int!
    private var permission:Int!
    private var createat:String!
    private var dateend:String!
    private var logged:Int!
    private var deleted:Int!
    private var onofflocation:Int!
    private var namecompany:String!
    private var taxcode:String!
    private var sofax:String!
    private var fanpage:String!
    private var idpack:Int!
    private var website:String!
    private var review:Int!
    private var latcompany:Double!
    private var lngcompany:Double!
    private var like:Int!//number like company
    private var totaltour:Int!
    private var distance:Double!
    private var user:String!//like not like tour
    private var googleplus:String!
    private var twitter:String!
    
    var _iduser : Int! {
        get{
            return self.iduser
        }
        set(value) {
            self.iduser = value
        }
    }
    var _username : String! {
        get{
            return self.username
        }
        set(value) {
            self.username = value
        }
    }
    var _password : String! {
        get{
            return self.password
        }
        set(value) {
            self.password = value
        }
    }
    var _phone : String! {
        get{
            return self.phone
        }
        set(value) {
            self.phone = value
        }
    }
    var _hotline : String! {
        get{
            return self.hotline
        }
        set(value){
            self.hotline = value
        }
    }
    var _phonecompany : String! {
        get{
            return self.hotline
        }
        set(value){
            self.phonecompany = value
        }
    }
    var _birthday : String! {
        get{
            return self.birthday
        }
        set(value) {
            self.birthday = value
        }
    }
    var _passport : String! {
        get{
            return self.passport
        }
        set(value) {
            self.passport = value
        }
    }
    var _identity_card : String! {
        get{
            return self.identity_card
        }
        set(value) {
            self.identity_card = value
        }
    }
    var _address : String! {
        get{
            return self.address
        }
        set(value) {
            self.address = value
        }
    }
    var _email : String! {
        get{
            return self.email
        }
        set(value) {
            self.email = value
        }
    }
    var _lat : Double! {
        get{
            return self.lat
        }
        set(value) {
            self.lat = value
        }
    }
    var _lng : Double! {
        get{
            return self.lng
        }
        set(value) {
            self.lng = value
        }
    }
    var _detailname : String! {
        get{
            return self.detailname
        }
        set(value) {
            self.detailname = value
        }
    }
    var _gender : Int! {
        get{
            return self.gender
        }
        set(value) {
            self.gender = value
        }
    }
    var _avatar : String! {
        get{
            return self.avatar
        }
        set(value) {
            self.avatar = value
        }
    }
    var _logocompany : String! {
        get{
            return self.logocompany
        }
        set(value) {
            self.logocompany = value
        }
    }
    var _lock : Int! {
        get{
            return self.lock
        }
        set(value) {
            self.lock = value
        }
    }
    var _permission : Int! {
        get{
            return self.permission
        }
        set(value) {
            self.permission = value
        }
    }
    var _createat : String! {
        get{
            return self.createat
        }
        set(value) {
            self.createat = value
        }
    }
    var _dateend : String! {
        get{
            return self.dateend
        }
        set(value) {
            self.dateend = value
        }
    }
    var _logged : Int! {
        get{
            return self.logged
        }
        set(value) {
            self.logged = value
        }
    }
    var _deleted : Int! {
        get{
            return self.deleted
        }
        set(value) {
            self.deleted = value
        }
    }
    var _onofflocation : Int! {
        get{
            return self.onofflocation
        }
        set(value) {
            self.onofflocation = value
        }
    }
    var _namecompany : String! {
        get{
            return self.namecompany
        }
        set(value) {
            self.namecompany = value
        }
    }
    var _taxcode : String! {
        get{
            return self.taxcode
        }
        set(value) {
            self.taxcode = value
        }
    }
    var _sofax : String! {
        get{
            return self.sofax
        }
        set(value) {
            self.sofax = value
        }
    }
    var _fanpage : String! {
        get{
            return self.fanpage
        }
        set(value) {
            self.fanpage = value
        }
    }
    var _idpack : Int! {
        get{
            return self.idpack
        }
        set(value) {
            self.idpack = value
        }
    }
    var _website : String! {
        get{
            return self.website
        }
        set(value) {
            self.website = value
        }
    }
    var _review : Int! {
        get{
            return self.review
        }
        set(value) {
            self.review = value
        }
    }
    var _latcompany : Double! {
        get{
            return self.latcompany
        }
        set(value) {
            self.latcompany = value
        }
    }
    var _lngcompany : Double! {
        get{
            return self.lngcompany
        }
        set(value) {
            self.lngcompany = value
        }
    }
    var _like : Int! {
        get{
            return self.like
        }
        set(value) {
            self.like = value
        }
    }
    var _totaltour : Int! {
        get{
            return self.totaltour
        }
        set(value) {
            self.totaltour = value
        }
    }
    var _distance : Double! {
        get{
            return self.distance
        }
        set(value) {
            self.distance = value
        }
    }
    var _user : String! {
        get{
            return self.user
        }
        set(value) {
            self.user = value
        }
    }
    var _googleplus : String! {
        get{
            return self.googleplus
        }
        set(value) {
            self.googleplus = value
        }
    }
    var _twitter : String! {
        get{
            return self.twitter
        }
        set(value) {
            self.twitter = value
        }
    }

    override init(){
        iduser = -1
        username = ""
        password = ""
        phone = ""
        phonecompany = ""
        hotline = ""
        birthday = ""
        passport = ""
        identity_card = ""
        address = ""
        email = ""
        lat = 0
        lng = 0
        detailname = ""
        avatar = ""
        logocompany = ""
        lock = 1
        permission = -1
        createat = ""
        dateend = ""
        logged = 0
        deleted = 0
        onofflocation = 0
        namecompany = ""
        taxcode = ""
        sofax = ""
        fanpage = ""
        idpack = -1
        website = ""
        review = -1
        latcompany = 0
        lngcompany = 0
        like = 0
        totaltour = 0
        distance = 0
        hotline = ""
        user = ""
        googleplus = ""
        twitter = ""
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
    
    init(iduser:Int, username:String, password:String, phone:String, phonecompany:String, hotline:String, birthday:String, passport:String,identity_card:String, address:String, email:String, lat:Double, lng:Double, detailname:String, avatar:String, logocompany:String, lock:Int, permission:Int, createat:String, dateend:String, logged:Int, deleted:Int, onofflocation:Int, namecompany:String, taxcode:String, sofax:String, fanpage:String, idpack:Int, website:String, review:Int, latcompany:Double, lngcompany:Double, like:Int, totaltour:Int, distance:Double, user:String, googleplus:String, twitter:String){
        self.iduser = iduser
        self.username = username
        self.password = password
        self.phone = phone
        self.phonecompany = phonecompany
        self.hotline = hotline
        self.birthday = birthday
        self.passport = passport
        self.identity_card = identity_card
        self.address = address
        self.email = email
        self.lat = lat
        self.lng = lng
        self.detailname = detailname
        self.avatar = avatar
        self.logocompany = logocompany
        self.lock = lock
        self.permission = permission
        self.createat = createat
        self.dateend = dateend
        self.logged = logged
        self.deleted = deleted
        self.onofflocation = onofflocation
        self.namecompany = namecompany
        self.taxcode = taxcode
        self.sofax = sofax
        self.fanpage = fanpage
        self.idpack = idpack
        self.website = website
        self.review = review
        self.latcompany = latcompany
        self.lngcompany = lngcompany
        self.like = like
        self.totaltour = totaltour
        self.distance = distance
        self.user = user
        self.googleplus = googleplus
        self.twitter = twitter
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        let iduser = aDecoder.decodeObject(forKey: "iduser") as! Int
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let phonecompany = aDecoder.decodeObject(forKey: "phonecompany") as! String
        let hotline = aDecoder.decodeObject(forKey: "hotline") as! String
        let birthday = aDecoder.decodeObject(forKey: "birthday") as! String
        let passport = aDecoder.decodeObject(forKey: "passport") as! String
        let identity_card = aDecoder.decodeObject(forKey: "identity_card") as! String
        let address = aDecoder.decodeObject(forKey: "address") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let lat = aDecoder.decodeObject(forKey: "lat") as! Double
        let lng = aDecoder.decodeObject(forKey: "lng") as! Double
        let detailname = aDecoder.decodeObject(forKey: "detailname") as! String
        let avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        let logocompany = aDecoder.decodeObject(forKey: "logocompany") as! String
        let lock = aDecoder.decodeObject(forKey: "lock") as! Int
        let permission = aDecoder.decodeObject(forKey: "permission") as! Int
        let createat = aDecoder.decodeObject(forKey: "createat") as! String
        let dateend = aDecoder.decodeObject(forKey: "dateend") as! String
        let logged = aDecoder.decodeObject(forKey: "logged") as! Int
        let deleted = aDecoder.decodeObject(forKey: "deleted") as! Int
        let onofflocation = aDecoder.decodeObject(forKey: "onofflocation") as! Int
        let namecompany = aDecoder.decodeObject(forKey: "namecompany") as! String
        let taxcode = aDecoder.decodeObject(forKey: "taxcode") as! String
        let sofax = aDecoder.decodeObject(forKey: "sofax") as! String
        let fanpage = aDecoder.decodeObject(forKey: "fanpage") as! String
        let idpack = aDecoder.decodeObject(forKey: "idpack") as! Int
        let website = aDecoder.decodeObject(forKey: "website") as! String
        let review = aDecoder.decodeObject(forKey: "review") as! Int
        let latcompany = aDecoder.decodeObject(forKey: "latcompany") as! Double
        let lngcompany = aDecoder.decodeObject(forKey: "lngcompany") as! Double
        let like = aDecoder.decodeObject(forKey: "like") as! Int
        let totaltour = aDecoder.decodeObject(forKey: "totaltour") as! Int
        let distance = aDecoder.decodeObject(forKey: "distance") as! Double
        let user = aDecoder.decodeObject(forKey: "user") as! String
        let googleplus = aDecoder.decodeObject(forKey: "googleplus") as! String
        let twitter = aDecoder.decodeObject(forKey: "twitter") as! String
        self.init(iduser: iduser, username: username, password: password, phone: phone, phonecompany:phonecompany, hotline: hotline, birthday: birthday, passport: passport, identity_card: identity_card, address: address, email: email, lat: lat, lng: lng, detailname: detailname, avatar: avatar, logocompany: logocompany, lock: lock, permission: permission, createat: createat, dateend: dateend, logged: logged, deleted: deleted, onofflocation: onofflocation, namecompany: namecompany, taxcode: taxcode, sofax: sofax, fanpage: fanpage, idpack: idpack, website: website, review: review, latcompany: latcompany, lngcompany: lngcompany, like: like, totaltour:totaltour, distance:distance, user:user, googleplus:googleplus, twitter:twitter)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(iduser, forKey: "iduser")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(phonecompany, forKey: "phonecompany")
        aCoder.encode(hotline, forKey: "hotline")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(passport, forKey: "passport")
        aCoder.encode(identity_card, forKey: "identity_card")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        aCoder.encode(detailname, forKey: "detailname")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(logocompany, forKey: "logocompany")
        aCoder.encode(lock, forKey: "lock")
        aCoder.encode(permission, forKey: "permission")
        aCoder.encode(createat, forKey: "createat")
        aCoder.encode(dateend, forKey: "dateend")
        aCoder.encode(logged, forKey: "logged")
        aCoder.encode(deleted, forKey: "deleted")
        aCoder.encode(onofflocation, forKey: "onofflocation")
        aCoder.encode(namecompany, forKey: "namecompany")
        aCoder.encode(taxcode, forKey: "taxcode")
        aCoder.encode(sofax, forKey: "sofax")
        aCoder.encode(fanpage, forKey: "fanpage")
        aCoder.encode(idpack, forKey: "idpack")
        aCoder.encode(website, forKey: "website")
        aCoder.encode(review, forKey: "review")
        aCoder.encode(latcompany, forKey: "latcompany")
        aCoder.encode(lngcompany, forKey: "lngcompany")
        aCoder.encode(like, forKey: "like")
        aCoder.encode(totaltour, forKey: "totaltour")
        aCoder.encode(distance, forKey: "distance")
        aCoder.encode(user, forKey: "user")
        aCoder.encode(googleplus, forKey: "googleplus")
        aCoder.encode(twitter, forKey: "twitter")
    }
    
    static func parseJson(userjson: JSON) -> User{
        let user:User = User()
        if let iduser = userjson["iduser"].int { user._iduser = iduser }
        if let username = userjson["username"].string { user._username = username }
        if let password = userjson["password"].string { user._password = password }
        if let phone = userjson["phone"].string { user._phone = phone }
        if let phonecompany = userjson["phonecompany"].string { user._phonecompany = phonecompany }
        if let hotline = userjson["hotline"].string { user._hotline = hotline }
        if let birthday = userjson["birthday"].string { user._birthday = birthday }
        if let passport = userjson["passport"].string { user._passport = passport }
        if let identity_card = userjson["identity_card"].string { user._identity_card = identity_card }
        if let address = userjson["address"].string { user._address = address }
        if let email = userjson["email"].string { user._email = email }
        if let lat = userjson["lat"].double { user._lat = lat }
        if let lng = userjson["lng"].double { user._lng = lng }
        if let detailname = userjson["detailname"].string { user._detailname = detailname }
        if let gender = userjson["gender"].int { user._gender = gender }
        if let avatar = userjson["avatar"].string { user._avatar = avatar }
        if let logocompany = userjson["logocompany"].string { user._logocompany = logocompany }
        if let lock = userjson["lock"].int { user._lock = lock }
        if let permission = userjson["permission"].int { user._permission = permission }
        if let createat = userjson["createat"].string { user._createat = createat }
        if let dateend = userjson["dateend"].string { user._dateend = dateend }
        if let logged = userjson["logged"].int { user._logged = logged }
        if let deleted = userjson["deleted"].int { user._deleted = deleted }
        if let onofflocation = userjson["onofflocation"].int { user._onofflocation = onofflocation }
        if let namecompany = userjson["namecompany"].string { user._namecompany = namecompany }
        if let taxcode = userjson["taxcode"].string { user._taxcode = taxcode }
        if let sofax = userjson["sofax"].string { user._sofax = sofax }
        if let fanpage = userjson["fanpage"].string { user._fanpage = fanpage }
        if let idpack = userjson["idpack"].int { user._idpack = idpack }
        if let website = userjson["website"].string { user._website = website }
        if let review = userjson["review"].int { user._review = review }
        if let latcompany = userjson["latcompany"].double { user._latcompany = latcompany }
        if let lngcompany = userjson["lngcompany"].double { user._lngcompany = lngcompany }
        if let like = userjson["like"].int { user._like = like }
        if let totaltour = userjson["totaltour"].int { user._totaltour = totaltour }
        if let distance = userjson["distance"].double { user._distance = distance }
        if let userl = userjson["user"].string { user._user = userl }
        if let googleplus = userjson["googleplus"].string { user._googleplus = googleplus }
        if let twitter = userjson["twitter"].string { user._twitter = twitter }
        return user
    }
    
}
