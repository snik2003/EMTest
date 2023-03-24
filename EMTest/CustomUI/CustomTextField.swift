//
//  CustomTextField.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

final class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCustomTextField()
    }

    func setupCustomTextField() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 14.5
        
        self.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        self.textColor = UIColor(red: 22.0/255, green: 24.0/255, blue: 38.0/255, alpha: 1.0)
        self.tintColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        
        self.font = UIFont(name: "Montserrat Medium", size: 14)
        self.text = ""
        
        self.borderStyle = .roundedRect
        
        if let placeholder = self.placeholder, !placeholder.isEmpty {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.482, green: 0.482, blue: 0.482, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "Montserrat Regular", size: 11)!
            ]
            
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
}
