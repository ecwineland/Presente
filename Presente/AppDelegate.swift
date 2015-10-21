//
//  AppDelegate.swift
//  Presente
//
//  Created by Evan Wineland on 10/8/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate  {
    
    var window: UIWindow?
    
    let beaconManager = ESTBeaconManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Beacon manager
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        startMonitoring()
        
        UIApplication.sharedApplication().registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        
        // Set Parse application ID
        Parse.setApplicationId("duoZSNacMsPkrkBfLrOuWAqFPjIKBKMBWSSw1l9m",
            clientKey: "CBYhaogTdvnJBDRseuU89y7gCIBE4dIUQBZCBuL9")
        
        return true
    }
    
    // Turn on background monitoring
    func startMonitoring() {
        self.beaconManager.startMonitoringForRegion(CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
            major: 10190, minor: 37362, identifier: "monitored region"))
    }
    
    // Turn off background monitoring
    func stopMonitoring() {
        self.beaconManager.stopMonitoringForRegion(CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
            major: 10190, minor: 37362, identifier: "monitored region"))
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "It's good to see you!  You're checked off for attending today's class."
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

