//
//  ColorsSectionCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

class ColorsSectionCell: UICollectionViewCell, NibLoadableView, ReusableView {

    weak var collectionView: UICollectionView!
    
    var viewModel: GoodDetailsViewModelDelegate?
    var index: Int?
    
    @IBOutlet weak var colorButton: UIButton!
    
    @IBAction func colorButtonAction() {
        guard let viewModel = viewModel else { return }
        guard let index = index else { return }
        
        guard viewModel.currentGood().selectedColorIndex != index else { return }
        
        colorButton.viewTouched {
            viewModel.currentGood().selectedColorIndex = index
            self.collectionView.reloadData()
        }
    }
}

extension ColorsSectionCell {
    
    func configure(color: UIColor, currentIndex: Int) {
        self.index = currentIndex
        
        colorButton.clipsToBounds = true
        colorButton.backgroundColor = color
        colorButton.layer.cornerRadius = 8.0
        
        colorButton.layer.borderWidth = 1.0
        colorButton.layer.borderColor = UIColor(red: 0.678, green: 0.678, blue: 0.678, alpha: 1).cgColor
        
        guard let viewModel = viewModel else { return }
        guard viewModel.currentGood().selectedColorIndex == currentIndex else { return }
        
        colorButton.layer.borderWidth =  2.4
        colorButton.layer.borderColor = UIColor.systemBlue.cgColor
        
    }
}
