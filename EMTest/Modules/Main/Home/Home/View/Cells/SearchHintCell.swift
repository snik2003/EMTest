//
//  SearchHintCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 17.03.2023.
//

import UIKit

class SearchHintCell: UITableViewCell, NibLoadableView, ReusableView {

    var delegate: SearchHintViewDelegate?
    var selectedHint: String?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selectButtonAction() {
        
        guard let delegate = delegate else { return }
        guard let selectedHint = selectedHint else { return }
        
        backView.viewTouched {
            delegate.select(selectedHint)
        }
    }
}

extension SearchHintCell {
    
    func configure(hint: String) {
        self.selectedHint = hint
        self.hintLabel.text = hint
    }
}
