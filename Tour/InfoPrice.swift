//
//  InfoPrice.swift
//  Tour
//
//  Created by tnt on 6/18/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoPrice : NSObject, NSCoding {
    private var type:String!
    private var price:Double!
    private var pricediscount:Double!
    private var idprogram:Int!
    private var currency:String!
    
    var _type : String!{
        get{
            return self.type
        }
        set(value){
            self.type = value
        }
    }
    var _price : Double! {
        get{
            return self.price
        }
        set(value){
            self.price = value
        }
    }
    var _pricediscount : Double! {
        get{
            return self.pricediscount
        }
        set(value){
            self.pricediscount = value
        }
    }
    var _idprogram : Int! {
        get{
            return self.idprogram
        }
        set(value){
            self.idprogram = value
        }
    }
    var _currency : String! {
        get{
            return self.currency
        }
        set(value){
            self.currency = value
        }
    }
    override init(){
        type = ""
        price = 0.0
        pricediscount = 0.0
        idprogram = 0
        currency = "VND"
    }
    init(type:String, price:Double, pricediscount:Double, idprogram:Int, currency:String){
        self.type = type
        self.price = price
        self.pricediscount = pricediscount
        self.idprogram = idprogram
        self.currency = currency
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(pricediscount, forKey: "pricediscount")
        aCoder.encode(idprogram, forKey: "tyidprogrampe")
        aCoder.encode(currency, forKey: "currency")
    }
    required convenience init(coder aDecoder: NSCoder) {
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let price = aDecoder.decodeObject(forKey: "price") as! Double
        let pricediscount = aDecoder.decodeObject(forKey: "pricediscount") as! Double
        let idprogram = aDecoder.decodeObject(forKey: "idprogram") as! Int
        let currency = aDecoder.decodeObject(forKey: "currency") as! String
        self.init(type: type, price: price, pricediscount: pricediscount, idprogram: idprogram, currency: currency)
    }
    
    static func parseJson(infopricejson: JSON) -> InfoPrice{
        let infoprice:InfoPrice = InfoPrice()
        if let type = infopricejson["type"].string { infoprice._type = type }
        if let price = infopricejson["price"].double { infoprice._price = price }
        
        if let pricediscount = infopricejson["pricediscount"].double { infoprice._pricediscount = pricediscount }
        if let idprogram = infopricejson["idprogram"].int { infoprice._idprogram = idprogram }
        if let currency = infopricejson["currency"].string { infoprice._currency = currency }
        return infoprice
    }
    
    static func parseArrayJson(infopricearrayjson: JSON) -> [InfoPrice]{
        var arrayInfoPrice:[InfoPrice]=[InfoPrice]()
        for i in infopricearrayjson.arrayValue {
            let infoprice:InfoPrice = self.parseJson(infopricejson: i)
            arrayInfoPrice.append(infoprice)
        }
        return arrayInfoPrice
    }
    
    static func getMaxInfoPriceItem(arrayInfoPrice: [InfoPrice]) -> InfoPrice{
        var infoprice:InfoPrice = InfoPrice()
        for i in 0 ..< arrayInfoPrice.count {
            if infoprice._price < arrayInfoPrice[i]._price {
                infoprice = arrayInfoPrice[i]
            }
            
        }
        return infoprice
    }
}
