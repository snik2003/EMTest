//
//  LatestGoodModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import Foundation
import SwiftyJSON

class LatestGoodModel {
    
    var name: String
    var category: String
    var price: Double
    var imageURL: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.category = json["category"].stringValue
        self.price = json["price"].doubleValue
        self.imageURL = json["image_url"].stringValue
    }
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var stringPrice: String {
        guard let value = numberFormatter.string(from: NSNumber(value: self.price)) else { return "$ 0,00" }
        return "$ " + value
    }
}
