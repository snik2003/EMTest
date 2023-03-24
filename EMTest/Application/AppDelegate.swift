//
//  AppDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var appCoordinator : AppCoordinator!

    lazy var coreDataStack: CoreDataStack = .init(modelName: "AuthModel")
    
    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unexpected app delegate type")
        }
        return delegate
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController.init()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }


}

