import UIKit
import PopupDialog
import SystemConfiguration
import SVProgressHUD

extension UIViewController {
    func alert(message:String){
        let title = "THÔNG BÁO"
        let message = message
        let popup = PopupDialog(title: title, message: message, image: nil)
        let buttonOne = DefaultButton(title: "OK") {
            print("You canceled the car dialog.")
        }
        //popup.addButtons([buttonOne, buttonTwo, buttonThree])
        popup.addButtons([buttonOne])
        popup.transitionStyle = .bounceUp
        popup.buttonAlignment = .horizontal
        self.present(popup, animated: true, completion: nil)
    }
    func alertLoginOrRegister(){
        let title = "THÔNG BÁO"
        let message = "Yêu cầu đăng nhập"
        let popup = PopupDialog(title: title, message: message, image: nil)
        let buttonOne = DefaultButton(title: "Đăng ký") {
            self.showRegister()
        }
        let buttonTwo = DefaultButton(title: "Đăng nhập") {
            let revealViewController:SWRevealViewController = self.revealViewController()
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        let buttonThree = DefaultButton(title: "Huỷ") {
            print("You canceled the car dialog.")
        }
        //popup.addButtons([buttonOne, buttonTwo, buttonThree])
        popup.addButtons([buttonOne,buttonTwo,buttonThree])
        popup.transitionStyle = .bounceUp
        popup.buttonAlignment = .horizontal
        self.present(popup, animated: true, completion: nil)
    }
    
    func showRegister(){
        let title = "Điều khoản sử dụng"
        let message = "Khi click đăng ký, bạn đã đồng ý với điều khoản của chúng tôi"
        let popup = PopupDialog(title: title, message: message)
        let revealViewController:SWRevealViewController = self.revealViewController()
        let buttonOne = DefaultButton(title: "Xem điều khoản") {
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "RulesViewController") as! RulesViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        let buttonTwo = DefaultButton(title: "Huỷ") {
            print("You canceled the car dialog.")
        }
        let buttonThree = DefaultButton(title: "Đồng ý", height: 60) {
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        self.present(popup, animated: true, completion: nil)
    }
    func popupWarningConnection(){
        let title = "LỖI KHÔNG CÓ MẠNG"
        let message = "Vui Lòng Kiểm Tra Lại Kết Nối Mạng"
        let popup = PopupDialog(title: title, message: message, image: nil)
        let buttonOne = DefaultButton(title: "OK") {
            print("You canceled the car dialog.")
        }
        //popup.addButtons([buttonOne, buttonTwo, buttonThree])
        popup.addButtons([buttonOne])
        popup.transitionStyle = .bounceUp
        popup.buttonAlignment = .horizontal
        self.present(popup, animated: true, completion: nil)
    }
    func geturl(url:String) -> String {
        return url.replacingOccurrences(of: "./", with: GetDataFromURL.URL_IMAGE)
    }
    func checkCode(code:String) -> String {
        var message:String!
        switch code {
        case "1000":
            message = "Thành Công"
        case "1001":
            message = "Thất Bại"
        case "1002":
            message = "Đã Tồn Tại"
        case "1003":
            message = "Không Tồn Tại"
        case "1004":
            message = "Không Có Dữ Liệu"
        case "9998":
            message = "Chưa Đăng Nhập"
        case "9999":
            message = "Lỗi"
        default:
            message = "Chưa Định Nghĩa Code"
        }
        return message
    }
    func layoutButtonNav(btnShowAndHideMenu:UIBarButtonItem){
        btnShowAndHideMenu.target = revealViewController()
        btnShowAndHideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    func emitDataSocketLocal(event:String, data: AnyObject) -> NotificationCenter{
        let keyUserDefaultLocalSocket:String = "keyLocalDataSocket" + event
        let center = NotificationCenter.default
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(encodedData, forKey: keyUserDefaultLocalSocket)
        center.post(name: NSNotification.Name(rawValue: event), object: nil)
        return center
    }
    func emitDataSocketLocal(event:String) -> NotificationCenter{
        let center = NotificationCenter.default
        center.post(name: NSNotification.Name(rawValue: event), object: nil)
        return center
    }
    func registerDataSocketLocal(event:String, selector:Selector) -> NotificationCenter{
        let center = NotificationCenter.default
        center.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: event), object: nil)
        return center
    }
    func getDataSocketLocal(event:String) -> AnyObject?{
        let keyUserDefaultLocalSocket:String = "keyLocalDataSocket" + event
        if let data = UserDefaults.standard.data(forKey: keyUserDefaultLocalSocket){
            let object = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject
            return object
        }
        return nil
    }
    
    func initLayerView(v:UIView){
        v.layer.cornerRadius = 5
        let shadowPath2 = UIBezierPath(rect: v.bounds)
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowPath = shadowPath2.cgPath
        v.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        v.layer.shouldRasterize = true
    }
    func runCallPhoneNumber(number:String){
        print("call sdt: \(number)")
        if number == ""{
            self.alert(message: "Không thấy số điện thoại")
        }
        if let phoneurl:NSURL = NSURL(string:"tel://\(number)"){
            let app:UIApplication = UIApplication.shared
            if app.canOpenURL(phoneurl as URL){
                app.open(phoneurl as URL, options: [:], completionHandler: nil)
            }
        }
    }
}
