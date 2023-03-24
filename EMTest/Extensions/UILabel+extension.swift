//
//  UILabel+extension.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

extension UILabel {
    
    func changeColorOfPartText(_ changeText: String, color: UIColor) {
        
        guard let fullText = self.text, !fullText.isEmpty else { return }
        
        let fullString: NSString = fullText as NSString
        let range = fullString.range(of: changeText)
        
        let attributedText = NSMutableAttributedString(string: fullText)
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: color]
        
        attributedText.addAttributes(attributes, range: range)
        self.attributedText = attributedText
    }
    
    func changeColorAndFontOfPartText(_ changeText: String, color: UIColor, font: UIFont) {
        
        guard let fullText = self.text, !fullText.isEmpty else { return }
        
        let fullString: NSString = fullText as NSString
        let range = fullString.range(of: changeText)
        
        let attributedText = NSMutableAttributedString(string: fullText)
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
        
        attributedText.addAttributes(attributes, range: range)
        self.attributedText = attributedText
    }
}
