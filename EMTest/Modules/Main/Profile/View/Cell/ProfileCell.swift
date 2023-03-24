//
//  ProfileCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class ProfileCell: UITableViewCell, NibLoadableView, ReusableView {
    
    var viewModel: ProfileViewModelDelegate?
    var model: ProfileCellModel?
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var disclosure: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selectButtonAction() {
        guard let viewModel = viewModel else { return }
        guard let model = model else { return }
        
        backView.viewTouched {
            switch model {
            case .logOut:
                viewModel.goToAuth()
            default:
                break
            }
        }
    }
}

extension ProfileCell {
    
    func configure(model: ProfileCellModel) {
        self.model = model
        
        icon.image = model.icon
        nameLabel.text = model.rawValue
        
        switch model.type {
        case .disclosure:
            balanceLabel.alpha = 0.0
            disclosure.alpha = 1.0
        case .balance:
            balanceLabel.text = viewModel?.getUserBalanceString()
            balanceLabel.alpha = 1.0
            disclosure.alpha = 0.0
        default:
            balanceLabel.alpha = 0.0
            disclosure.alpha = 0.0
        }
    }
}
