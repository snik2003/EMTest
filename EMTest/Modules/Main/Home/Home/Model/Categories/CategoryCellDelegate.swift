//
//  CategoryCellDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

protocol CategoryCellProtocol: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dataSource: [CategoryCellModel] { get set }
    
    var viewModel: HomeViewModelDelegate { get set }
    
    var collectionView: UICollectionView { get set }
    
    func reloadData()
}

class CategoryCellDelegate: NSObject, CategoryCellProtocol {
    
    var dataSource: [CategoryCellModel]
    
    var viewModel: HomeViewModelDelegate
    
    var collectionView: UICollectionView
    
    init(dataSource: [CategoryCellModel], collectionView: UICollectionView, viewModel: HomeViewModelDelegate) {
    
        self.dataSource = dataSource
        self.viewModel = viewModel
        self.collectionView = collectionView
        
        self.collectionView.register(CategoryCell.self)
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
        let cell: CategoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel
        cell.configure(model: dataSource[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.zero
    }
}
