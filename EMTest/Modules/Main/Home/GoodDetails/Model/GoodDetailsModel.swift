//
//  GoodDetailsModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit
import SwiftyJSON

class GoodDetailsModel: Equatable {
    
    var name: String
    var details: String
    var price: Double
    var rating: Double
    var reviewsNumber: Int
    var colors: [UIColor]
    
    var imageURLs: [String]
    var images: [String: UIImage]
    
    var selectedColorIndex: Int
    var selectedImageIndex: Int
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.details = json["description"].stringValue
        self.price = json["price"].doubleValue
        self.rating = json["rating"].doubleValue
        self.reviewsNumber = json["number_of_reviews"].intValue
        self.colors = []
        
        self.imageURLs = json["image_urls"].compactMap({ $0.1.stringValue })
        self.images = [:]
        
        self.selectedColorIndex = 0
        self.selectedImageIndex = 0
        
        let hexColors = json["colors"].compactMap({ $0.1.stringValue })
        for hex in hexColors {
            let color = hexStringToUIColor(hex: hex)
            colors.append(color)
        }
    }
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private var numberFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var stringPrice: String {
        guard let value = numberFormatter.string(from: NSNumber(value: self.price)) else { return "$ 0,00" }
        return "$ " + value
    }
    
    var stringRatingAndReviews: String {
        let reviews = " (" + String(self.reviewsNumber) + " reviews)"
        guard let value = numberFormatter2.string(from: NSNumber(value: self.rating)) else { return "0,0" + reviews }
        return value + reviews
    }
    
    var stringReviews: String {
        return "(" + String(self.reviewsNumber) + " reviews)"
    }
    
    static func == (lhs: GoodDetailsModel, rhs: GoodDetailsModel) -> Bool {
        lhs.name == rhs.name && lhs.price == rhs.price
    }
}

extension GoodDetailsModel {
    
    private func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
