//
//  AppDelegate.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/11/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let listingCoordinator = ListingCoordinator()

        let rootVC = listingCoordinator.listingVC

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        return true
    }
}
