//
//  SelectImageCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

class SelectImageCell: UITableViewCell, NibLoadableView, ReusableView {

    var imagesCount: Int = 0
    
    let screenWidth = UIScreen.main.bounds.width
    
    var collectionViewDelegate: ImagesSectionDelegate!
    var viewModel: GoodDetailsViewModelDelegate!
    var scrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint!
    
}

extension SelectImageCell {
    
    func configure(model: GoodDetailsModel) {
        imagesCount = model.images.count
        var images: [UIImage] = []
        
        guard let viewModel = viewModel else { return }
        
        var scrollWidth: CGFloat = 24
        
        setupScrollView()
        
        for index in 0 ..< model.imageURLs.count {
            guard let image = model.images[model.imageURLs[index]] else { continue }
            
            images.append(image)
            createImageView(leftX: scrollWidth, image: image)
            createLikeForm(leftX: scrollWidth)
            scrollWidth += screenWidth - 24
        }
        
        scrollView.contentSize = CGSize(width: scrollWidth, height: 280)
        scrollImage(forPage: viewModel.good.selectedImageIndex)
        
        collectionViewWidthConstraint.constant = fmin(screenWidth - 18, CGFloat(103 + 65 * (imagesCount - 1)))
        collectionViewDelegate = ImagesSectionDelegate(dataSource: images, collectionView: collectionView,
                                                       viewModel: viewModel, scrollView: scrollView)
        collectionViewDelegate.reloadData()
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 280)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = false
        self.addSubview(scrollView)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        swipeLeft.direction = .left
        swipeRight.direction = .right
        
        scrollView.addGestureRecognizer(swipeLeft)
        scrollView.addGestureRecognizer(swipeRight)
        scrollView.isUserInteractionEnabled = true
    }
    
    private func createImageView(leftX: CGFloat, image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x: leftX, y: 5, width: screenWidth - 60, height: 270)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(red: 0.678, green: 0.678, blue: 0.678, alpha: 1).cgColor
        scrollView.addSubview(imageView)
    }
    
    private func createLikeForm(leftX: CGFloat) {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.937, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 12.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.678, green: 0.678, blue: 0.678, alpha: 1).cgColor
        view.frame = CGRect(x: leftX + screenWidth - 86, y: 151, width: 42, height: 95)
        
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 0.329, green: 0.333, blue: 0.537, alpha: 1)
        separator.frame = CGRect(x: 15, y: 47, width: 12, height: 1.0)
        view.addSubview(separator)
        
        let likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(named: "like-image"), for: .normal)
        likeButton.frame = CGRect(x: 11, y: 15, width: 20, height: 20)
        view.addSubview(likeButton)
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share-image"), for: .normal)
        
        shareButton.frame = CGRect(x: 11, y: 60, width: 20, height: 20)
        view.addSubview(shareButton)
        
        scrollView.addSubview(view)
    }
    
    private func scrollImage(forPage page: Int) {
        switch page {
        case 0:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1 ..< imagesCount - 1:
            scrollView.setContentOffset(CGPoint(x: CGFloat(page) * (screenWidth - 24), y: 0), animated: true)
        case imagesCount - 1:
            scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width - screenWidth, y: 0), animated: true)
        default:
            break
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        
        guard let viewModel = viewModel else { return }
        
        if sender.direction == .right && viewModel.good.selectedImageIndex > 0 {
            viewModel.good.selectedImageIndex -= 1
        }
        
        if sender.direction == .left && viewModel.good.selectedImageIndex < imagesCount - 1 {
            viewModel.good.selectedImageIndex += 1
        }
        
        scrollImage(forPage: viewModel.good.selectedImageIndex)
        collectionView.reloadData()
    }
    
}
