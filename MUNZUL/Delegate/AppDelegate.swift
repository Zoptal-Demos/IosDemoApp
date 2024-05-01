//
//  AppDelegate.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 05/03/24.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("")
        GMSPlacesClient.provideAPIKey("")
        IQKeyboardManager.shared.enable = true

        if AuthenticationManager.shared.isLoggedIn {
            let window = UIWindow(frame: UIScreen.main.bounds)
              let navigationController = UINavigationController()
              let appCoordinator = AppCoordinator(navigationController: navigationController)
              appCoordinator.NavigateToTabBar()
//            appCoordinator.start()

              window.rootViewController = navigationController
              window.makeKeyAndVisible()

        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
              let navigationController = UINavigationController()
              let appCoordinator = AppCoordinator(navigationController: navigationController)
              appCoordinator.start()

              window.rootViewController = navigationController
              window.makeKeyAndVisible()
        }

           // Initialize UIWindow
   
          return true
      }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

