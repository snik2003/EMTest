//
//  APIModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import Foundation
import Alamofire

enum APIModel {
    case latestGoods
    case flashSale
    case goodDetails
    case searchGoods
    case downloadImage(imageURL: String)
    
    private var host: String {
        return "https://run.mocky.io/v3/"
    }
    
    private var path: String {
        switch self {
        case .latestGoods:
            return "cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale:
            return "a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .goodDetails:
            return "f7f99d04-4971-45d5-92e0-70333383c239"
        case .searchGoods:
            return "4c9cd822-9479-4509-803d-63197e5a9e19"
        default:
            return ""
        }
    }
    
    private var headers: [String: String] {
        return [:]
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var requestURL: String {
        switch self {
        case let .downloadImage(imageURL):
            return imageURL
        default:
            return host + path
        }
    }
    
    var request: GetServerDataOperation {
        return GetServerDataOperation(url: requestURL, parameters: nil, method: method, headers: headers)
    }
}

