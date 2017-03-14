//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Pari, Nithya on 2/24/17.
//  Copyright © 2017 Pari, Nithya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //Storing the current time when the app enters background
        storeCurrentTime(reason: "App entering background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let defaults = UserDefaults.standard
        let resetBillAmountFlag = checkToResetBillAmount()
        defaults.set(resetBillAmountFlag, forKey: "resetBillAmountKey")
        
        //Setting default theme as dark - 0
        let selectedTippyThemePosition:Int = 0
        defaults.set(selectedTippyThemePosition, forKey:"defaultTippyThemeKey")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        //Storing the current time when the app terminates
        storeCurrentTime(reason: "App Termination")
    }
    
    /**
     * This method is used to store the current date
     **/
    func storeCurrentTime(reason: String) {
        
        let defaults = UserDefaults.standard
        let currentTime = NSDate()
        defaults.set(currentTime, forKey: "currentTimeKey")
        defaults.synchronize()
        print("App current time stored for : "+reason)
        print(currentTime)
    }
    
    func checkToResetBillAmount()  -> Bool {
        
        let defaults = UserDefaults.standard
        let storedTime = defaults.object(forKey: "currentTimeKey")
        var shouldResetBill:Bool = false
        if(storedTime != nil) {
            shouldResetBill = checkIfMoreThanTenMins(storedTime: storedTime as! Date)
        }
        
        return shouldResetBill
    }
    
    func checkIfMoreThanTenMins(storedTime: Date)  -> Bool {
        
        let currentTime = NSDate()
        print("Stored Time")
        print(storedTime)
        print("Current Time")
        print(currentTime)
        let timeGap = Int(currentTime.timeIntervalSince(storedTime))
        print(Int(timeGap))
        if(timeGap > 600){
            return true
            
            //Reset the 
        }
        return false
    }
    


}

