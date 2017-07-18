//
//  Message.swift
//  Tour
//
//  Created by tnt on 7/10/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class Message : NSObject, NSCoding{
    private var id:Int!
    private var to:String!
    private var content:String!
    private var detailname:String!
    private var type:Int!
    private var avatar:String!
    private var deleted:Int!
    private var createat:Int64!
    private var listseen:String!
    private var idtour:Int!
    private var received:Int!
    private var usersender:String!
    var _id:Int!{
        get{
            return self.id
        }
        set(value){
            self.id = value
        }
    }
    var _to:String!{
        get{
            return self.to
        }
        set(value){
            self.to = value
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
    var _detailname:String!{
        get{
            return self.detailname
        }
        set(value){
            self.detailname = value
        }
    }
    var _type:Int!{
        get{
            return self.type
        }
        set(value){
            self.type = value
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
    var _deleted:Int!{
        get{
            return self.deleted
        }
        set(value){
            self.deleted = value
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
    var _listseen:String!{
        get{
            return self.listseen
        }
        set(value){
            self.listseen = value
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
    var _received:Int!{
        get{
            return self.received
        }
        set(value){
            self.received = value
        }
    }
    var _usersender:String!{
        get{
            return self.usersender
        }
        set(value){
            self.usersender = value
        }
    }
    override init(){
        id = 0
        to = ""
        content = ""
        detailname = ""
        type = 0
        avatar = ""
        deleted = 0
        createat = 0
        listseen = ""
        idtour = 0
        received = 0
        usersender = ""
    }
    init(id:Int, to:String, content:String, detailname:String, type:Int, avatar:String, deleted:Int, createat:Int64, listseen:String, idtour:Int, received:Int, usersender:String){
        self.id = id
        self.to = to
        self.content = content
        self.detailname = detailname
        self.type = type
        self.avatar = avatar
        self.deleted = deleted
        self.createat = createat
        self.listseen = listseen
        self.idtour = idtour
        self.received = received
        self.usersender = usersender
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(to, forKey: "to")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(detailname, forKey: "detailname")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(deleted, forKey: "deleted")
        aCoder.encode(createat, forKey: "createat")
        aCoder.encode(listseen, forKey: "listseen")
        aCoder.encode(idtour, forKey: "idtour")
        aCoder.encode(received, forKey: "received")
        aCoder.encode(usersender, forKey: "usersender")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let to = aDecoder.decodeObject(forKey: "to") as! String
        let content = aDecoder.decodeObject(forKey: "content") as! String
        let detailname = aDecoder.decodeObject(forKey: "detailname") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! Int
        let avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        let deleted = aDecoder.decodeObject(forKey: "deleted") as! Int
        let createat = aDecoder.decodeObject(forKey: "createat") as! Int64
        let listseen = aDecoder.decodeObject(forKey: "listseen") as! String
        let idtour = aDecoder.decodeObject(forKey: "idtour") as! Int
        let received = aDecoder.decodeObject(forKey: "received") as! Int
        let usersender = aDecoder.decodeObject(forKey: "usersender") as! String
        self.init(id: id, to: to, content: content, detailname: detailname, type: type, avatar: avatar, deleted: deleted, createat: createat, listseen: listseen, idtour: idtour, received: received, usersender: usersender)
    }
    static func parseJson(jsonobject: JSON) -> Message{
        let obj:Message = Message()
        if let id = jsonobject["id"].int { obj._id = id }
        if let to = jsonobject["to"].string { obj._to = to }
        if let content = jsonobject["content"].string { obj._content = content }
        if let detailname = jsonobject["detailname"].string { obj._detailname = detailname }
        if let type = jsonobject["type"].int { obj._type = type }
        if let avatar = jsonobject["avatar"].string { obj._avatar = avatar }
        if let deleted = jsonobject["deleted"].int { obj._deleted = deleted }
        if let createat = jsonobject["createat"].int64 { obj._createat = createat }
        if let listseen = jsonobject["listseen"].string { obj._listseen = listseen }
        if let idtour = jsonobject["idtour"].int { obj._idtour = idtour }
        if let received = jsonobject["received"].int { obj._received = received }
        if let usersender = jsonobject["usersender"].string { obj._usersender = usersender }
        return obj
    }
    static func parseArrayJson(arrayjson: JSON) -> [Message]{
        var arrayobj:[Message]=[Message]()
        for i in 0...(arrayjson.count-1) {
            let obj:Message = self.parseJson(jsonobject: arrayjson[i])
            arrayobj.append(obj)
        }
        return arrayobj
    }
    static func parseArrayJson(stringdata: String) -> [Message]{
        let jarr:JSON = JSON(data: (stringdata as NSString).data(using: String.Encoding.utf8.rawValue)!)
        return self.parseArrayJson(arrayjson: jarr)
    }
}
