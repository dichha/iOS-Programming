//
//  AppDelegate.swift
//  Bouncer
//
//  Created by raidi01 on 4/21/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //AppDelegate is a global place
    struct Motion {
       static let Manager = CMMotionManager()
        
    }

}

