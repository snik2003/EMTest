//
//  ColorsSectionDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

protocol ColorsSectionProtocol: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dataSource: [UIColor] { get}
    
    var viewModel: GoodDetailsViewModelDelegate { get }
    
    var collectionView: UICollectionView { get }
    
    func reloadData()
    
}

class ColorsSectionDelegate: NSObject, ColorsSectionProtocol {
    
    var dataSource: [UIColor]
    
    var viewModel: GoodDetailsViewModelDelegate
    
    var collectionView: UICollectionView
    
    init(dataSource: [UIColor], collectionView: UICollectionView, viewModel: GoodDetailsViewModelDelegate) {
    
        self.dataSource = dataSource
        self.viewModel = viewModel
        self.collectionView = collectionView
        
        self.collectionView.register(ColorsSectionCell.self)
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
        let cell: ColorsSectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel
        cell.collectionView = collectionView
        cell.configure(color: dataSource[indexPath.row], currentIndex: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 48, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.zero
    }
}
