//
//  APIManager.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    
    func getLatestGoods(success: @escaping ([LatestGoodModel]) -> (Void), failure: @escaping (String) -> (Void))
    
    func getFlashSaleGoods(success: @escaping ([FlashSaleModel]) -> (Void), failure: @escaping (String) -> (Void))
    
    func getGoodDetails(success: @escaping (GoodDetailsModel) -> (Void), failure: @escaping (String) -> (Void))
    
    func searchGoods(completion: @escaping ([String]) -> (Void))
    
    func downloadImage(imageURL: String, completion: @escaping (UIImage?) -> (Void))
}

final class APIManager: APIManagerProtocol {
    
    func getLatestGoods(success: @escaping ([LatestGoodModel]) -> (Void), failure: @escaping (String) -> (Void)) {
        
        let request = APIModel.latestGoods.request
        request.completionBlock = {
            OperationQueue.main.addOperation {
                guard let json = request.json else {
                    failure(DataInputError.serverError.rawValue)
                    return
                }
                
                let latest = json["latest"].compactMap({ LatestGoodModel(json: $0.1) })
                success(latest)
            }
        }
        OperationQueue().addOperation(request)
    }
    
    func getFlashSaleGoods(success: @escaping ([FlashSaleModel]) -> (Void), failure: @escaping (String) -> (Void)) {
        
        let request = APIModel.flashSale.request
        request.completionBlock = {
            OperationQueue.main.addOperation {
                guard let json = request.json else {
                    failure(DataInputError.serverError.rawValue)
                    return
                }
                
                var flash = json["flash_sale"].compactMap({ FlashSaleModel(json: $0.1) })
                
                // искуственно удвоим количество товаров, приходящих по API,
                // чтобы визуально продемонстрировать реализацию карусели
                // flash.append(contentsOf: flash)
                
                success(flash)
            }
        }
        OperationQueue().addOperation(request)
    }
    
    func getGoodDetails(success: @escaping (GoodDetailsModel) -> (Void), failure: @escaping (String) -> (Void)) {
        
        let request = APIModel.goodDetails.request
        request.completionBlock = {
            OperationQueue.main.addOperation {
                guard let json = request.json else {
                    failure(DataInputError.serverError.rawValue)
                    return
                }
                
                
                let good = GoodDetailsModel(json: json)
                
                let dispatchGroup = DispatchGroup()
                var images: [String: UIImage] = [:]
                
                for imageURL in good.imageURLs {
                    dispatchGroup.enter()
                    self.downloadImage(imageURL: imageURL) { image in
                        guard let image = image else { dispatchGroup.leave(); return }
                        images[imageURL] = image
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    good.images = images
                    success(good)
                }
            }
        }
        OperationQueue().addOperation(request)
    }
    
    func searchGoods(completion: @escaping ([String]) -> (Void)) {
        
        let request = APIModel.searchGoods.request
        request.completionBlock = {
            OperationQueue.main.addOperation {
                guard let json = request.json else {
                    completion([])
                    return
                }
                
                let words = json["words"].compactMap({ $0.1.stringValue })
                completion(words)
            }
        }
        OperationQueue().addOperation(request)
    }
    
    func downloadImage(imageURL: String, completion: @escaping (UIImage?) -> (Void)) {
        
        let request = APIModel.downloadImage(imageURL: imageURL).request
        request.completionBlock = {
            guard let data = request.data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
        OperationQueue().addOperation(request)
    }
}
