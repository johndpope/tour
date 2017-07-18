
import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    init(timezone:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        self = dateFormatter.date(from: timezone)!
    }
    func convertTimeString() -> String {
        let date:Date = Date(timeIntervalSince1970: TimeInterval(self.millisecondsSince1970 / 1000))
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let dateString:String = String(hour)+":"+String(minutes)
        return dateString
    }
    func convertDateString() -> String {
        let date:Date = Date(timeIntervalSince1970: TimeInterval(self.millisecondsSince1970 / 1000))
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)
        let y = calendar.component(.year, from: date)
        let dateString:String = String(d)+"-"+String(m)+"-"+String(y)
        return dateString
    }
    
    func convertMilisecondsToDateString() -> String {
        let date:Date = Date(timeIntervalSince1970: TimeInterval(self.millisecondsSince1970 / 1000))
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)
        let y = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
//        print(d)
//        print(m)
//        print(y)
//        print(hour)
//        print(minutes)
//        let dateString:String = d+"-"+m+"-"+y+" "+hour+":"+minutes
        let dateString:String = String(d)+"-"+String(m)+"-"+String(y)+" "+String(hour)+":"+String(minutes)
//        print(dateString)
        return dateString
    }
    
    func offsetWithCurrentTime() -> String{
        let datenow:Date = Date()
        let offsetMiliseconds:Int64 = self.millisecondsSince1970 - datenow.millisecondsSince1970
        var offset:String!
        if(offsetMiliseconds > 86400000){
            offset = String(offsetMiliseconds/84600000)+" Ngày"
        }else{
            let hour = offsetMiliseconds/1000/60/60
            let minutes = (offsetMiliseconds/1000/60)%60
//            print(offsetMiliseconds)
            offset = String(hour)+":"+String(minutes)
        }
        return offset
    }
}
