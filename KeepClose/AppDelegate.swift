//
//  AppDelegate.swift
//  KeepClose
//
//  Created by Nishant on 05/10/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import UserNotifications

var r_value: Int = 0    //used to indicate the rssi value
var beacon: CLBeacon?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var gameTimer: Timer!
    var locationManager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString:"23A01AF0-232A-4518-9C0E-323FB773F5EF")!, major: 0, minor: 0, identifier: "MyBeacon")
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // RAO: Path for Core Data.
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("RAO: \(path[path.count - 1] as URL)")
        
        // For region monitoring.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
        
        //For notifications
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // RAO: Register Backgroundtask.
        self.registerBackgroundTask()
        self.applicationState()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
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
        let container = NSPersistentContainer(name: "KeepClose")
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

}

// RAO: AppDelegate and Context for Core Data.
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

// MARK: CLLocationManagerDelegate.
extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        for beacon: CLBeacon in beacons {
            //print(beacon.rssi)
           r_value = beacon.rssi
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLBeaconRegion else { return }
        
//        let content = UNMutableNotificationContent()
//        content.title = "KeepClose"
//        content.body = "Entered the region!"
//        content.sound = .default()
//
//        for _ in 1...20 {
//
//            let request = UNNotificationRequest(identifier: "KeepClose", content: content, trigger: nil)
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard region is CLBeaconRegion else { return }
        
//        let content = UNMutableNotificationContent()
//        content.title = "KeepClose"
//        content.body = "Are you forgetting something?"
//        content.sound = .default()
//
//        let request = UNNotificationRequest(identifier: "KeepClose", content: content, trigger: nil)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

// MARK: BackgroundTask
extension AppDelegate {
    
    func applicationState() {
        //call endBackgroundTask() on completion..
        switch UIApplication.shared.applicationState {
        case .active:
            print("App is active.")
        case .background:
            print("App is in background.")
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
            self.repeat_value()
        case .inactive:
            break
        }
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.update()
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    func repeat_value() {
        
        gameTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    @objc func update(){
        
        //print(r_value)
        
        let temp_uid = UUID(uuidString: "23A01AF0-232A-4518-9C0E-323FB773F5EF")
        
        print("GAGAN: \(globalBeacon.count)")
        
        if globalBeacon.count > 0 {
            
            if (r_value < -75 && globalBeacon[0].uuid == temp_uid) {
                                
                print("GAGAN: inside the if")
                let content = UNMutableNotificationContent()
                content.title = "CHECK YOUR BELONGINGS!"
                content.body = "You Might Be Forgetting Something"
                content.sound = .default()
                
                let request = UNNotificationRequest(identifier: "KeepClose", content: content, trigger: nil)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
}
