//
//  AppDelegate.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Запускаем локальное хранилище
        AppStorage.appStart()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = AppNavigationController()

        window?.makeKeyAndVisible()
        
        return true
    }
}
