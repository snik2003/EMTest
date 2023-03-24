//
//  FlashSaleModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import Foundation
import SwiftyJSON

class FlashSaleModel {
    
    var name: String
    var category: String
    var price: Double
    var discount: Int
    var imageURL: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.category = json["category"].stringValue
        self.price = json["price"].doubleValue
        self.discount = json["discount"].intValue
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
    
    var stringDiscount: String {
        return String(self.discount) + "% off"
    }
}
