//
//  CustomButton.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

final class CustomButton: UIButton {

    override var isEnabled: Bool {
        didSet { handleState() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isEnabled = true
        setupStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupStyle()
    }
    
    private func setColors() {
        self.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        self.titleLabel?.font = UIFont(name: "Montserrat SemiBold", size: 14)
        self.titleLabel?.textColor = .white
        
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
    }
    
    private func setCornerRadius() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 14.0
    }
    
    private func setupStyle() {
        setCornerRadius()
        setColors()
        setShadow()
        
    }
    
    private func handleState() {
        let animations: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.setupStyle()
        }
        
        UIView.animate(withDuration: 0.3, animations: animations)
    }
    
    private func setShadow() {
        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 14.0
        layer.masksToBounds = false
    }

}
