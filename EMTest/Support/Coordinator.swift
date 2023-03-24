//
//  Coordinator.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
