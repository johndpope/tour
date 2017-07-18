//
//  AppDelegate.swift
//  Tour
//
//  Created by tnt on 5/29/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire
import SystemConfiguration
import UserNotifications
import SwiftyJSON
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let manager = CLLocationManager()
    let keyGMS = "AIzaSyB4HovpI7oZPzvfCS0EeXFnufyP_T-yxXU"
    var isStartUpdatingLocation:Bool = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.alert,.sound]) { (granted, error) in}
            application.registerForRemoteNotifications()
        }
        else {
            let notifySetting = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySetting)
            UIApplication.shared.registerForRemoteNotifications()
        }
        //background fetch
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        self.registerDataSocketLocal(event: "logged", selector: #selector(logged))
        initGMap()
        return true
    }
    func initGMap(){
        GMSServices.provideAPIKey(keyGMS)
        GMSPlacesClient.provideAPIKey(keyGMS)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        updateLocationTour()
        
    }
    
    func logged(){
        print("logged data")
        if let user = self.getDataSocketLocal(event: "logged") as? User {
            SocketManager.establishConnection(username: user._username)
        }
        
    }
    func updateLocationTour(){
        let when = DispatchTime.now() + 30 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.isStartUpdatingLocation == false {
                print("start")
                self.manager.startUpdatingLocation()
                self.isStartUpdatingLocation = true
                self.updateLocationTour()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if self.isStartUpdatingLocation == true {
            manager.stopUpdatingLocation()
            self.isStartUpdatingLocation = false
            print("stop")
            let keyUserDefaultLocalSocket:String = StringUserdefaults.keyLoggedUserDefaultLocalSocket
            if let data = UserDefaults.standard.data(forKey: keyUserDefaultLocalSocket) {
                let user:User = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
                user._lat = location.coordinate.latitude
                user._lng = location.coordinate.longitude
                updateLocationUser(lat: user._lat, lng: user._lng)
                getListTourUseroftour()
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
                UserDefaults.standard.set(encodedData, forKey: keyUserDefaultLocalSocket)
                //            print("save location in logged")
            }else{
                UserDefaults.standard.set(location.coordinate.latitude, forKey: StringUserdefaults.latNotLogin)
                UserDefaults.standard.set(location.coordinate.longitude, forKey: StringUserdefaults.lngNotLogin)
                //            print("save location global")
            }
        }
        
    }
    
    func getListTourUseroftour(){
        let parameters: Parameters! = [:]
        //        print(parameters)
        Alamofire.request(GetDataFromURL.URL_GET_ALL_TOUR_USEROFTOUR, method: .post, parameters: parameters /*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    let code = json["code"].string! as String
                    if code == CodeServer.CODE_1000{
                        let listTour:[Tour] = Tour.parseArrayJson(tourarrayjson: json["data"])
                        for tour in listTour{
                            if tour._status == 1{
                                let keyUserDefaultLocalSocket:String = StringUserdefaults.keyLoggedUserDefaultLocalSocket
                                if let data = UserDefaults.standard.data(forKey: keyUserDefaultLocalSocket)
                                {
                                    let user:User = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
                                    self.updateLocationUseroftour(lat: user._lat, lng: user._lng, idtour: tour._idtour)
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        print("error in appdelegate")
                    }
                    break
                }
            })
    }
    func updateLocationUseroftour(lat:Double, lng:Double, idtour:Int){
        let parameters: Parameters! = [
            "lat":lat,
            "lng":lng,
            "idtour":idtour
        ]
        //        print(parameters)
        Alamofire.request(GetDataFromURL.URL_USEROFTOUR_UPDATE_USER, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    let json = JSON(data:response.data!)
                    print("useroftour update location")
//                    print(json)
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        print("error in appdelegate")
                    }
                    break
                }
            })
    }
    func updateLocationUser(lat:Double, lng:Double){
        let parameters: Parameters! = [
            "lat":lat,
            "lng":lng
        ]
        //        print(parameters)
        Alamofire.request(GetDataFromURL.URL_UPDATE_LOCATION_USER, method: .post, parameters: parameters/*,encoding: URLEncoding.httpBody*/)
            .validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseJSON(/*queue: queue ,*/ completionHandler:  {
                response in
                switch(response.result) {
                case .success(_):
                    print("user update location")
                    let json = JSON(data:response.data!)
//                    print(json)
                    break
                case .failure(_):
                    print("Error: ")
                    print(response.result.error as Any)
                    if response.result.error?._code == NSURLErrorTimedOut{
                        print("error in appdelegate")
                    }
                    break
                }
            })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("ResignActive")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("EnterBackground")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("EnterForeground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("DidBecomeActive")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("WillTerminate")
        
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Tour")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func registerDataSocketLocal(event:String, selector:Selector){
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: event), object: nil)
    }
    func getDataSocketLocal(event:String) -> AnyObject?{
        let keyUserDefaultLocalSocket:String = "keyLocalDataSocket" + event
        if let data = UserDefaults.standard.data(forKey: keyUserDefaultLocalSocket){
            let object = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject
            return object
        }
        return nil
    }
}

