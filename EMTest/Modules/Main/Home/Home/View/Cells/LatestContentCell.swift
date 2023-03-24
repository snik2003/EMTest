//
//  LatestContentCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

class LatestContentCell: UITableViewCell, NibLoadableView, ReusableView {

    var viewModel: HomeViewModelDelegate?
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var carouselView: CarouselView!
    
    @IBAction func viewAllButtonAction() {
        guard let _ = viewModel else { return }
        
        viewAllButton.viewTouched {
            
        }
    }
}

extension LatestContentCell {
    
    func configure(dataSource: [LatestGoodModel]) {
        guard let viewModel = viewModel else { return }
        
        carouselView.setupInitialState(type: .latest, viewModel: viewModel)
        carouselView.configureView(withLatest: dataSource, andFlashSale: [])
    }
}
