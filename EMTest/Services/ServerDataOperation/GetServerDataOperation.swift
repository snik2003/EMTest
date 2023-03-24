//
//  GetServerDataOperation.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetServerDataOperation: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest
    private var url: String
    private var parameters: Parameters?
    private var method: HTTPMethod
    
    var data: Data?
    var code: Int?
    var error: Error?
    var json: JSON?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard let self = self else { return }
            
            self.data = nil
            self.json = nil
            self.code = response.response?.statusCode
            self.error = response.error
            
            if let data = response.data {
                self.data = data
                self.json = try? JSON(data: data)
            }
            
            self.state = .finished
        }
    }
    
    init(url: String, parameters: Parameters? = nil, method: HTTPMethod, headers: [String: String]) {
        self.url = url
        self.parameters = parameters
        self.method = method
        
        request = Alamofire.request(url, method: method, parameters: parameters, headers: headers)
    }
}

