//
//  GoodDetailsViewModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

protocol GoodDetailsViewModelDelegate {
    
    var coordinator: HomeCoordinator! { get }
    
    var apiManager: APIManagerProtocol! { get }
    
    var good: GoodDetailsModel! { get }
    
    func currentGood() -> GoodDetailsModel
    
    func backToPreviousPage()
    
    func downloadImage(fromURL imageURL: String, completion: @escaping (UIImage?) -> (Void))
}

class GoodDetailsViewModel: GoodDetailsViewModelDelegate {
    
    var coordinator: HomeCoordinator!
    
    var apiManager: APIManagerProtocol!
    
    var good: GoodDetailsModel!
    
    func currentGood() -> GoodDetailsModel {
        return good
    }
    
    func backToPreviousPage() {
        coordinator.backToPreviousPage()
    }
    
    func downloadImage(fromURL imageURL: String, completion: @escaping (UIImage?) -> (Void)) {
        
        apiManager.downloadImage(imageURL: imageURL, completion: { image in
            OperationQueue.main.addOperation {
                completion(image)
            }
        })
    }
}
