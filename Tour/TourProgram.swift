//
//  TourProgram.swift
//  Tour
//
//  Created by tnt on 6/21/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class TourProgram{
    private var id : Int!
    private var iduser : Int!
    private var idtour : Int!
    private var day : String!
    private var listimages : [String]!
    private var content : String!
    private var isShow : Bool!
    
    var _id : Int! {
        get{
            return self.id
        }
        set(value){
            self.id = value
        }
    }
    var _iduser : Int! {
        get{
            return self.iduser
        }
        set(value){
            self.iduser = value
        }
    }
    var _idtour : Int! {
        get{
            return self.idtour
        }
        set(value){
            self.idtour = value
        }
    }
    var _day : String! {
        get{
            return self.day
        }
        set(value){
            self.day = value
        }
    }
    var _listimages : [String]! {
        get{
            return self.listimages
        }
        set(value){
            self.listimages = value
        }
    }
    var _content : String! {
        get{
            return self.content
        }
        set(value){
            self.content = value
        }
    }
    var _isShow : Bool! {
        get{
            return self.isShow
        }
        set(value){
            self.isShow = value
        }
    }
    init(){
        self.id = 0
        self.iduser = 0
        self.idtour = 0
        self._day = ""
        self.listimages = [String]()
        self._content = ""
        self._isShow = false
        
    }
    init(id:Int, iduser:Int, idtour:Int, day:String, listimages:[String], content:String){
        self.id = id
        self.iduser = iduser
        self.idtour = idtour
        self.day = day
        self.listimages = listimages
        self.content = content
        self.isShow = false
    }
    
    static func parseJson(jsonobject:JSON) -> TourProgram{
//        print(jsonobject)
        let tourProgram:TourProgram = TourProgram()
        if let id = jsonobject["id"].int { tourProgram._id = id }
        if let iduser = jsonobject["iduser"].int { tourProgram._iduser = iduser }
        if let idtour = jsonobject["idtour"].int { tourProgram._idtour = idtour }
        if let day = jsonobject["day"].string { tourProgram._day = day }
        if let content = jsonobject["content"].string { tourProgram._content = content }
        
        let listimagesjson:JSON = JSON(data: (jsonobject["listimages"].string! as NSString).data(using: String.Encoding.utf8.rawValue)!)
        for i in listimagesjson.arrayValue{
            if let link:String = i.string {
                tourProgram._listimages.append(link)
            }
        }
        return tourProgram
    }
    
    static func parseJsonArray(jsonarray:JSON) -> [TourProgram]{
        var listTourProgram:[TourProgram] = [TourProgram]()
            for i in 0 ..< jsonarray.count {
                listTourProgram.append(TourProgram.parseJson(jsonobject: jsonarray[i]))
            }
    
        return listTourProgram
    }
}
