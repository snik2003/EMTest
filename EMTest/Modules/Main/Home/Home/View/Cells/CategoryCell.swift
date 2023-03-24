//
//  CategoryCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell, NibLoadableView, ReusableView {

    var viewModel: HomeViewModelDelegate?
    var model: CategoryCellModel?

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selectButtonAction() {
        guard let _ = viewModel else { return }
        guard let _ = model else { return }
        
        icon.viewTouched {

        }
    }
}

extension CategoryCell {
    
    func configure(model: CategoryCellModel) {
        self.model = model
        
        icon.image = model.icon
        nameLabel.text = model.rawValue
    }
}

