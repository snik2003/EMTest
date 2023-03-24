//
//  ImagesSectionDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

protocol ImagesSectionProtocol: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dataSource: [UIImage] { get}
    
    var viewModel: GoodDetailsViewModelDelegate { get }
    
    var collectionView: UICollectionView { get }
    
    var scrollView: UIScrollView { get }
    
    func reloadData()
    
}

class ImagesSectionDelegate: NSObject, ImagesSectionProtocol {
    
    var dataSource: [UIImage]
    
    var viewModel: GoodDetailsViewModelDelegate
    
    var collectionView: UICollectionView
    
    var scrollView: UIScrollView
    
    init(dataSource: [UIImage], collectionView: UICollectionView, viewModel: GoodDetailsViewModelDelegate, scrollView: UIScrollView) {
    
        self.dataSource = dataSource
        self.viewModel = viewModel
        self.collectionView = collectionView
        self.scrollView = scrollView
        
        self.collectionView.register(ImagesSectionCell.self)
    }
    
    func reloadData() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImagesSectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel
        cell.collectionView = collectionView
        cell.scrollView = scrollView
        cell.configure(image: dataSource[indexPath.row], currentIndex: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = viewModel.good.selectedImageIndex == indexPath.row ? 91 : 71
        let height = viewModel.good.selectedImageIndex == indexPath.row ? 49 : 39
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.zero
    }
}

