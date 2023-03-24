//
//  ProfileCoordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class ProfileCoordinator : Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    func start() {
        //
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func goToAuth() {
        if let authCoordinator = parentCoordinator as? AuthCoordinator {
            authCoordinator.goToRegisterPage()
        } else if let appCoordinator = parentCoordinator as? AppCoordinator {
            appCoordinator.goToAuth()
        }
    }
}
