//
//  SelectColorCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

class SelectColorCell: UITableViewCell, NibLoadableView, ReusableView {
    
    var viewModel: GoodDetailsViewModelDelegate!
    var collectionViewDelegate: ColorsSectionProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension SelectColorCell {
    
    func configure(colors: [UIColor]) {
        collectionViewDelegate = ColorsSectionDelegate(dataSource: colors, collectionView: collectionView, viewModel: viewModel)
        collectionViewDelegate.reloadData()
    }
}
