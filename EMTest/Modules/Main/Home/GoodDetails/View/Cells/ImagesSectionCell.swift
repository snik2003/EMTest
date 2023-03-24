//
//  ImagesSectionCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

class ImagesSectionCell: UICollectionViewCell, NibLoadableView, ReusableView {

    weak var collectionView: UICollectionView!
    weak var scrollView: UIScrollView!
    
    var viewModel: GoodDetailsViewModelDelegate?
    var index: Int?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageButtonHeightConstraint: NSLayoutConstraint!
    
    @IBAction func imageButtonAction() {
        guard let viewModel = viewModel else { return }
        guard let index = index else { return }
        
        guard viewModel.currentGood().selectedImageIndex != index else { return }
        
        imageButton.viewTouched {
            viewModel.currentGood().selectedImageIndex = index
            self.scrollImage(forPage: index, in: viewModel.currentGood().imageURLs.count)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.reloadData()
            })
        }
    }
}

extension ImagesSectionCell {
    
    func configure(image: UIImage, currentIndex: Int) {
        self.index = currentIndex
        
        imageView.image = image
        imageView.layer.cornerRadius = 8.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(red: 0.678, green: 0.678, blue: 0.678, alpha: 1).cgColor
        
        imageViewHeightConstraint.constant = 39.0
        imageButtonHeightConstraint.constant = 39.0
        
        guard let viewModel = viewModel else { return }
        guard viewModel.currentGood().selectedImageIndex == currentIndex else { return }
        
        imageViewHeightConstraint.constant = 49.0
        imageButtonHeightConstraint.constant = 49.0
        
        imageView.layer.borderWidth =  1.5
    }
    
    private func scrollImage(forPage page: Int, in count: Int) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        switch page {
        case 0:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1 ..< count - 1:
            scrollView.setContentOffset(CGPoint(x: CGFloat(page) * (screenWidth - 24), y: 0), animated: true)
        case count - 1:
            scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width - screenWidth, y: 0), animated: true)
        default:
            break
        }
    }
}

