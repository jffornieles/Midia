//
//  AppDelegate.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 25/02/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let tabBarController = window?.rootViewController as? UITabBarController,
            let homeViewController = tabBarController.viewControllers?.first as? HomeViewController,
            let searchViewController = tabBarController.viewControllers?[1] as? SearchViewController,
            let favoritesViewController = tabBarController.viewControllers?[2] as? FavoritesViewController
            else {
            fatalError("Wrong initial setup")
        }

        let currentMediaItemProvider = MediaItemProvider(withMediaItemKind: .movie)
        homeViewController.mediaItemProvider = currentMediaItemProvider
        searchViewController.mediaItemProvider = currentMediaItemProvider
        favoritesViewController.mediaItemProvider = currentMediaItemProvider
        

        return true
    }

}
