//
//  HomeCoordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class HomeCoordinator : Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    func start() {
        //
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func goToGoodDetailsPage(_ good: GoodDetailsModel) {
        let goosDetailsViewController: GoodDetailsViewController = GoodDetailsViewController.loadFromNib()
        
        let goodDetailsViewModel = GoodDetailsViewModel.init()
        goodDetailsViewModel.apiManager = APIManager()
        goodDetailsViewModel.coordinator = self
        goodDetailsViewModel.good = good
        
        goosDetailsViewController.viewModel = goodDetailsViewModel
        navigationController.pushViewController(goosDetailsViewController, animated: true)
    }
    
    func backToPreviousPage() {
        self.navigationController.popViewController(animated: true)
    }
}
