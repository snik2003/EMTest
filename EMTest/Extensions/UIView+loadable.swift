//
//  UIView+loadable.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

protocol NibLoadableView: AnyObject {
    
    static var nibName: String { get }
    
}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
