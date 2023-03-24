//
//  CartModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import Foundation

final class CartModel {
    
    static let shared = CartModel()
    
    var content: [GoodDetailsModel] = []
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var total: Double {
        var total = 0.0
        for good in content {
            total = total + good.price
        }
        return total
    }
    
    var stringTotal: String {
        guard let value = numberFormatter.string(from: NSNumber(value: self.total)) else { return "$ 0,00" }
        return "$ " + value
    }
}
