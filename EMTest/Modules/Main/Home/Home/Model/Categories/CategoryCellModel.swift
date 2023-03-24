//
//  CategoryCellModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

enum CategoryCellModel: String, CaseIterable {
    
    case phones = "Phones"
    case headphones = "Headphones"
    case games = "Games"
    case cars = "Cars"
    case furniture = "Furniture"
    case kids = "Kids"
    
    var icon: UIImage? {
        return UIImage(named: self.rawValue.lowercased())
    }
}
