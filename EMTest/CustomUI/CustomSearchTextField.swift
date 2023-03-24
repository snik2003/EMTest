//
//  CustomSearchTextField.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

final class CustomSearchTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCustomSearchTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCustomSearchTextField()
    }

    func setupCustomSearchTextField() {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.borderStyle = .none
        
        self.backgroundColor = .clear
        self.textColor = UIColor(red: 22.0/255, green: 24.0/255, blue: 38.0/255, alpha: 1.0)
        self.tintColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        
        self.font = UIFont(name: "Montserrat Medium", size: 12)
        self.text = ""
        
        if let placeholder = self.placeholder, !placeholder.isEmpty {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.357, green: 0.357, blue: 0.357, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "Montserrat Medium", size: 9)!
            ]
            
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
}

