//
//  AppCoordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
        
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("AppCoordinator inited")
    }
    
    func start() {
        UserDataService().loggedInUserId == nil ? goToAuth() : goToHome() 
        print("AppCoordinator started")
    }
    
    func goToAuth() {
        let authCoordinator = AuthCoordinator.init(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        authCoordinator.start()
    }
    
    func goToHome(){
        let coordinator = MainTabBarCoordinator.init(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    deinit {
        print("AppCoordinator deinited")
    }
}
