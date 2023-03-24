//
//  FlashSaleCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

class FlashSaleCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    var viewModel: HomeViewModelDelegate?
    weak var model: FlashSaleModel?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var goodImageView: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var addFavoritesButton: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBAction func selectButtonAction() {
        guard let viewModel = viewModel else { return }
        guard let _ = model else { return }
        
        backView.viewTouched {
            self.backView.showLoading()
            viewModel.getGoodDetails(success: { good in
                self.backView.hideLoading()
                viewModel.goToGoodDetails(good)
            }, failure: { _ in
                self.backView.hideLoading()
            })
        }
    }
    
    @IBAction func addCartButtonAction() {
        guard let _ = viewModel else { return }
        guard let _ = model else { return }
        
        addCartButton.viewTouched {
            
        }
    }
    
    @IBAction func addFavoritesButtonAction() {
        guard let _ = viewModel else { return }
        guard let _ = model else { return }
        
        addFavoritesButton.viewTouched {
            
        }
    }
    
    private var cachedImages: [String: UIImage] = [:]
}

extension FlashSaleCell {
    
    func configure(model: FlashSaleModel) {
        self.model = model
        
        categoryView.layer.cornerRadius = 9.0
        categoryLabel.text = model.category
        
        discountView.layer.cornerRadius = 9.0
        discountLabel.text = model.stringDiscount
        
        goodImageView.layer.cornerRadius = 14
        shadowView.layer.cornerRadius = 14
        
        nameLabel.text = model.name
        priceLabel.text = model.stringPrice
        
        if let image = cachedImages[model.imageURL] {
            goodImageView.image = image
            showManageElements(true)
        } else {
            guard let viewModel = viewModel else { return }
            
            DispatchQueue.global(qos: .userInitiated).async {
                viewModel.downloadImage(fromURL: model.imageURL) { [weak self] image in
                    DispatchQueue.main.async {
                        guard let self = self else {
                            self?.showManageElements(false)
                            return
                        }
                        
                        guard let image = image else {
                            self.showManageElements(false)
                            return
                        }
                        
                        self.goodImageView.image = image
                        self.cachedImages[model.imageURL] = image
                        self.showManageElements(true)
                    }
                }
            }
        }
    }
    
    private func showManageElements(_ show: Bool) {
        self.backView.alpha = show ? 1.0 : 0.0
        self.selectButton.alpha = show ? 1.0 : 0.0
        self.addCartButton.alpha = show ? 1.0 : 0.0
        self.addFavoritesButton.alpha = show ? 1.0 : 0.0
    }
}
