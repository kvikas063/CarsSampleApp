//
//  AppDelegate.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import UIKit
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var imageCache = NSCache<NSURL, UIImage>()
    var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Check for Internet Connection
        reachability = try? Reachability()
        try? reachability?.startNotifier()

        return true
    }


}

