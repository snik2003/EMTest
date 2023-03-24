//
//  AuthCoordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
        
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func start() {
        goToRegisterPage()
    }
    
    func goToRegisterPage() {
        let regViewController: RegisterViewController = RegisterViewController.loadFromNib()
        
        let regViewModel = RegisterViewModel.init()
        regViewModel.coordinator = self
        
        regViewController.viewModel = regViewModel
        navigationController.viewControllers = [regViewController]
    }
    
    func goToLoginPage() {
        let loginViewController: LoginViewController = LoginViewController.loadFromNib()
        
        let loginViewModel = LoginViewModel.init()
        loginViewModel.coordinator = self
        
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func backToRegisterPage() {
        navigationController.popViewController(animated: true)
    }
    
    func goToHome(){
        let coordinator = MainTabBarCoordinator.init(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
}
