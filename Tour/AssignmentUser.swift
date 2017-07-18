//
//  AssignmentUser.swift
//  Tour
//
//  Created by tnt on 6/16/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class AssignmentUser : NSObject, NSCoding {
    private var useridcompany:Int!
    private var useriduser:Int!
    private var numstart:Int!
    private var contentcomment:String!
    private var datecomment:Int64!
    private var avatar:String!
    private var detailname:String!
    private var isattent:Int!
    
    var _useridcompany : Int! {
        get{
            return self.useridcompany
        }
        set(value) {
            self.useridcompany = value
        }
    }
    var _useriduser : Int! {
        get{
            return self.useriduser
        }
        set(value) {
            self.useriduser = value
        }
    }
    var _numstart : Int! {
        get{
            return self.numstart
        }
        set(value) {
            self.numstart = value
        }
    }
    var _contentcomment : String! {
        get{
            return self.contentcomment
        }
        set(value) {
            self.contentcomment = value
        }
    }
    var _datecomment : Int64! {
        get{
            return self.datecomment
        }
        set(value) {
            self.datecomment = value
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
    var _detailname : String! {
        get{
            return self.detailname
        }
        set(value) {
            self.detailname = value
        }
    }
    var _isattent : Int! {
        get{
            return self.isattent
        }
        set(value) {
            self.isattent = value
        }
    }
  
    override init(){
        useridcompany = 0
        useriduser = 0
        numstart = 0
        contentcomment = ""
        datecomment = 0
        avatar = ""
        detailname = ""
        isattent = 0
    }
    init(useridcompany:Int, useriduser:Int, numstart:Int, contentcomment:String, datecomment:Int64, avatar:String, detailname:String, isattent:Int){
        self.useridcompany = useridcompany
        self.useriduser = useriduser
        self.numstart = numstart
        self.contentcomment = contentcomment
        self.datecomment = datecomment
        self.avatar = avatar
        self.detailname = detailname
        self.isattent = isattent
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(useridcompany, forKey: "useridcompany")
        aCoder.encode(useriduser, forKey: "useriduser")
        aCoder.encode(numstart, forKey: "numstart")
        aCoder.encode(contentcomment, forKey: "contentcomment")
        aCoder.encode(datecomment, forKey: "datecomment")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(detailname, forKey: "detailname")
        aCoder.encode(isattent, forKey: "isattent")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let useridcompany = aDecoder.decodeObject(forKey: "useridcompany") as! Int
        let useriduser = aDecoder.decodeObject(forKey: "useriduser") as! Int
        let numstart = aDecoder.decodeObject(forKey: "numstart") as! Int
        let contentcomment = aDecoder.decodeObject(forKey: "contentcomment") as! String
        let datecomment = aDecoder.decodeObject(forKey: "datecomment") as! Int64
        let avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        let detailname = aDecoder.decodeObject(forKey: "detailname") as! String
        let isattent = aDecoder.decodeObject(forKey: "isattent") as! Int
        
        self.init(useridcompany: useridcompany, useriduser: useriduser, numstart: numstart, contentcomment: contentcomment, datecomment: datecomment, avatar: avatar, detailname: detailname, isattent: isattent)
    }
    
    static func parseJson(assignmentUserJSON: JSON) -> AssignmentUser{
        let assignmentUser:AssignmentUser = AssignmentUser()
        if let useridcompany = assignmentUserJSON["useridcompany"].int{ assignmentUser._useridcompany = useridcompany }
        if let useriduser = assignmentUserJSON["useriduser"].int { assignmentUser._useriduser = useriduser }
        if let numstart = assignmentUserJSON["numstart"].int { assignmentUser._numstart = numstart }
        if let contentcomment = assignmentUserJSON["contentcomment"].string { assignmentUser._contentcomment = contentcomment }
        if let datecomment = assignmentUserJSON["datecomment"].int64 { assignmentUser._datecomment = datecomment }
        if let avatar = assignmentUserJSON["avatar"].string { assignmentUser._avatar = avatar }
        if let detailname = assignmentUserJSON["detailname"].string { assignmentUser._detailname = detailname }
        if let isattent = assignmentUserJSON["isattent"].int { assignmentUser._isattent = isattent }
        return assignmentUser
    }
    
}
