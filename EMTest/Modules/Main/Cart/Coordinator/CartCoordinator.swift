//
//  CartCoordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class CartCoordinator : Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    func start() {
        //
    }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
}
