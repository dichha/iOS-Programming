//
//  AppDelegate.swift
//  Trax
//
//  Created by raidi01 on 4/21/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

struct GPXURL {
    static let Notification = "GPXURL Radio Station"
    static let Key = "GPXURL URL Key"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? //pointer to a window so don't delete it
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: GPXURL.Notification, object: self, userInfo: [GPXURL.Key: url])
        //print("url = \(url)")
        center.postNotification(notification)
        return true
    }


    

}

