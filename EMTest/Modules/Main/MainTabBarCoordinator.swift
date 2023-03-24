//
//  MainTabBarCoordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
        
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        initializeMainTabBar()
    }
    
    func initializeMainTabBar() {
        
        let tabbarItem1 = initHomePage()
        let tabbarItem2 = initFavoritesPage()
        let tabbarItem3 = initCartPage()
        let tabbarItem4 = initChatPage()
        let tabbarItem5 = initProfilePage()
        
        let tabbarVC = MainTabBarController.init()
        tabbarVC.viewControllers = [tabbarItem1, tabbarItem2, tabbarItem3, tabbarItem4, tabbarItem5]
        
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.isTranslucent = false
        navigationController.viewControllers = [tabbarVC]
    }
    
    func initHomePage() -> UINavigationController {
        let homeViewModel = HomeViewModel.init()
        let homeViewController: HomeViewController = HomeViewController.loadFromNib()
        
        let apiManager = APIManager()
        homeViewModel.apiManager = apiManager
        
        let tabbarVC = UINavigationController.init()
        tabbarVC.navigationBar.isTranslucent = false
        tabbarVC.viewControllers = [homeViewController]
        tabbarVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar0"), tag: 0)
        
        let homeCoordinator = HomeCoordinator(navigationController: tabbarVC)
        homeCoordinator.parentCoordinator = parentCoordinator
        
        homeViewModel.coordinator = homeCoordinator
        homeViewController.viewModel = homeViewModel
        
        return tabbarVC
    }
    
    func initFavoritesPage() -> UINavigationController {
        let favViewModel = FavoritesViewModel.init()
        let favViewController: FavoritesViewController = FavoritesViewController.loadFromNib()
        
        let tabbarVC = UINavigationController.init()
        tabbarVC.navigationBar.isTranslucent = false
        tabbarVC.viewControllers = [favViewController]
        tabbarVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar1"), tag: 1)
        
        let favCoordinator = FavoritesCoordinator(navigationController: tabbarVC)
        favCoordinator.parentCoordinator = parentCoordinator
        
        favViewModel.coordinator = favCoordinator
        favViewController.viewModel = favViewModel
        
        return tabbarVC
    }
    
    func initCartPage() -> UINavigationController {
        let cartViewModel = CartViewModel.init()
        let cartViewController: CartViewController = CartViewController.loadFromNib()
        
        let tabbarVC = UINavigationController.init()
        tabbarVC.navigationBar.isTranslucent = false
        tabbarVC.viewControllers = [cartViewController]
        tabbarVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar2"), tag: 2)
        
        let cartCoordinator = CartCoordinator(navigationController: tabbarVC)
        cartCoordinator.parentCoordinator = parentCoordinator
        
        cartViewModel.coordinator = cartCoordinator
        cartViewController.viewModel = cartViewModel
        
        return tabbarVC
    }
    
    func initChatPage() -> UINavigationController {
        let chatViewModel = ChatViewModel.init()
        let chatViewController: ChatViewController = ChatViewController.loadFromNib()
        
        let tabbarVC = UINavigationController.init()
        tabbarVC.navigationBar.isTranslucent = false
        tabbarVC.viewControllers = [chatViewController]
        tabbarVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar3"), tag: 3)
        
        let chatCoordinator = ChatCoordinator(navigationController: tabbarVC)
        chatCoordinator.parentCoordinator = parentCoordinator
        
        chatViewModel.coordinator = chatCoordinator
        chatViewController.viewModel = chatViewModel
        
        return tabbarVC
    }
    
    func initProfilePage() -> UINavigationController {
        let profileViewModel = ProfileViewModel.init()
        let profileViewController: ProfileViewController = ProfileViewController.loadFromNib()
        
        let tabbarVC = UINavigationController.init()
        tabbarVC.navigationBar.isTranslucent = false
        tabbarVC.viewControllers = [profileViewController]
        tabbarVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar4"), tag: 4)
        
        let profileCoordinator = ProfileCoordinator(navigationController: tabbarVC)
        profileCoordinator.parentCoordinator = parentCoordinator
        
        profileViewModel.coordinator = profileCoordinator
        profileViewController.viewModel = profileViewModel
        
        return tabbarVC
    }
}
