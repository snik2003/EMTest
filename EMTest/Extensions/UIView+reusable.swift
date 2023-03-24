//
//  UIView+reusable.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    
    static var defaultReuseIdentifier: String { get }
    
}

extension ReusableView where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
