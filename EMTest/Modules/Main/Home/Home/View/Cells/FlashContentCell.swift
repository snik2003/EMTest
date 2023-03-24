//
//  FlashContentCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

class FlashContentCell: UITableViewCell, NibLoadableView, ReusableView {
    
    var viewModel: HomeViewModelDelegate?
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var carouselView: CarouselView!
    
    @IBAction func viewAllButtonAction() {
        guard let _ = viewModel else { return }
        
        viewAllButton.viewTouched {
            
        }
    }
}

extension FlashContentCell {
    
    func configure(dataSource: [FlashSaleModel]) {
        guard let viewModel = viewModel else { return }
        
        carouselView.setupInitialState(type: .flashSale, viewModel: viewModel)
        carouselView.configureView(withLatest: [], andFlashSale: dataSource)
    }
}

