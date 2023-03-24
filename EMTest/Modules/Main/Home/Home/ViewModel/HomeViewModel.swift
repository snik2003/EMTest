//
//  HomeViewModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

protocol HomeViewModelDelegate {
    
    var coordinator: HomeCoordinator! { get }
    
    var apiManager: APIManagerProtocol! { get }
    
    func getUserIcon(completion: @escaping (UIImage) -> Void)
    
    func getHomeContent(success: @escaping ([LatestGoodModel], [FlashSaleModel]) -> (Void), failure: @escaping (String) -> (Void))
    
    func getGoodDetails(success: @escaping (GoodDetailsModel) -> (Void), failure: @escaping (String) -> (Void))
    
    func searchGoods(forText text: String, completion: @escaping ([String]) -> (Void))
    
    func downloadImage(fromURL imageURL: String, completion: @escaping (UIImage?) -> (Void))
    
    func goToGoodDetails(_ good: GoodDetailsModel)
}

class HomeViewModel: HomeViewModelDelegate {
    
    var coordinator: HomeCoordinator!
    
    var apiManager: APIManagerProtocol!
    
    var defaultPhoto: UIImage {
        return UIImage(named: "default-user-icon")!
    }
    
    func getUserIcon(completion: @escaping (UIImage) -> Void) {
        guard let userId = UserDataService().loggedInUserId else {
            completion(defaultPhoto)
            return
        }
        
        AuthUserData.getUser(withUserId: userId) { user in
            guard let user = user else {
                completion(self.defaultPhoto)
                return
            }
            
            completion(user.photo)
        }
    }
    
    func getHomeContent(success: @escaping ([LatestGoodModel], [FlashSaleModel]) -> (Void), failure: @escaping (String) -> (Void)) {
        
        apiManager.getLatestGoods(success: { [weak self] latestGoods in
            guard let self = self else { return }
            
            self.apiManager.getFlashSaleGoods(success: { flashSale in
                success(latestGoods, flashSale)
            }, failure: { message in
                failure(message)
            })
        }, failure: { message in
            failure(message)
        })
    }
    
    func getGoodDetails(success: @escaping (GoodDetailsModel) -> (Void), failure: @escaping (String) -> (Void)) {
        
        apiManager.getGoodDetails(success: { good in
            success(good)
        }, failure: { message in
            failure(message)
        })
    }
    
    func searchGoods(forText text: String, completion: @escaping ([String]) -> (Void)) {
        
        apiManager.searchGoods { words in
            let result = words.filter({ $0.localizedCaseInsensitiveContains(text) })
            completion(result)
        }
    }
    
    func downloadImage(fromURL imageURL: String, completion: @escaping (UIImage?) -> (Void)) {
        
        apiManager.downloadImage(imageURL: imageURL, completion: { image in
            OperationQueue.main.addOperation {
                completion(image)
            }
        })
    }
    
    func goToGoodDetails(_ good: GoodDetailsModel) {
        coordinator.goToGoodDetailsPage(good)
    }
}
