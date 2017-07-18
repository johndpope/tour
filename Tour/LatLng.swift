import Foundation
class LatLng:NSObject,NSCoding  {
    private var lat : String!
    var _lat : String! {
        get{
            return self.lat
        }
        set(value) {
            self.lat = value
        }
    }
    override init() {
        self.lat = ""
    }
    init(lat:String) {
        self.lat = lat
    }
    required convenience init(coder aDecoder: NSCoder) {
        let lat = aDecoder.decodeObject(forKey: "lat") as! String
        self.init(lat:lat)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: "lat")
    }
}
