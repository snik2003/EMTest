//
//  CartPanel.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

final class CartPanel: UIView {

    weak var good: GoodDetailsModel!
    
    private var quantityLabel: UILabel!
    private var minusButton: UIButton!
    private var plusButton: UIButton!
    private var addButton: UIButton!
    
    private var addCartLabel: UILabel!
    private var totalLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupInitialState()
    }
    
    private func setupInitialState() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor(red: 0.094, green: 0.09, blue: 0.149, alpha: 1)
        self.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        
        
        quantityLabel = UILabel()
        quantityLabel.text = "Quantity:"
        quantityLabel.textColor = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1)
        quantityLabel.font = UIFont(name: "Montserrat SemiBold", size: 8)
        quantityLabel.frame = CGRect(x: 24, y: 10, width: 50, height: 20)
        self.addSubview(quantityLabel)
        
        
        minusButton = UIButton(type: .system)
        minusButton.setTitle("−", for: .normal)
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.titleLabel?.font = UIFont(name: "Montserrat SemiBold", size: 20)
        minusButton.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        minusButton.clipsToBounds = true
        minusButton.layer.cornerRadius = 8.0
        minusButton.frame = CGRect(x: 24, y: 38, width: 38, height: 22)
        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        self.addSubview(minusButton)
        
        
        plusButton = UIButton(type: .system)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.titleLabel?.font = UIFont(name: "Montserrat SemiBold", size: 18)
        plusButton.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        plusButton.clipsToBounds = true
        plusButton.layer.cornerRadius = 8.0
        plusButton.frame = CGRect(x: 83, y: 38, width: 38, height: 22)
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        self.addSubview(plusButton)
        
        
        addButton = UIButton(type: .system)
        addButton.setTitle("", for: .normal)
        addButton.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 14.0
        addButton.frame = CGRect(x: UIScreen.main.bounds.width - 194, y: 19, width: 170, height: 44)
        self.addSubview(addButton)
        
        
        addCartLabel = UILabel()
        addCartLabel.text = "ADD TO CART"
        addCartLabel.textColor = .white
        addCartLabel.textAlignment = .center
        addCartLabel.adjustsFontSizeToFitWidth = true
        addCartLabel.minimumScaleFactor = 0.5
        addCartLabel.font = UIFont(name: "Montserrat Bold", size: 8)
        addCartLabel.frame = CGRect(x: 85, y: 12, width: 60, height: 20)
        addButton.addSubview(addCartLabel)
        
        
        totalLabel = UILabel()
        totalLabel.text = "$ 0,00"
        totalLabel.textColor = UIColor(red: 0.6, green: 0.627, blue: 1, alpha: 1)
        totalLabel.adjustsFontSizeToFitWidth = true
        totalLabel.minimumScaleFactor = 0.5
        totalLabel.font = UIFont(name: "Montserrat SemiBold", size: 8)
        totalLabel.frame = CGRect(x: 30, y: 14, width: 50, height: 16)
        addButton.addSubview(totalLabel)
        
        self.reloadData()
    }
    
    func reloadData() {
        totalLabel.text = CartModel.shared.stringTotal
        minusButton.isEnabled = CartModel.shared.content.count > 0
        addButton.isEnabled = CartModel.shared.content.count > 0
    }
    
    @objc private func minusButtonAction() {
        guard CartModel.shared.content.count > 0 else { return }
        
        minusButton.viewTouched { [weak self] in
            guard let self = self else { return }
            
            CartModel.shared.content.removeFirst()
            self.reloadData()
        }
    }
    
    @objc private func plusButtonAction() {
        plusButton.viewTouched { [weak self] in
            guard let self = self else { return }
            
            CartModel.shared.content.append(self.good)
            self.reloadData()
        }
    }
}
