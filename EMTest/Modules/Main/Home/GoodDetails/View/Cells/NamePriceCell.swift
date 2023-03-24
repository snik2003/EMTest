//
//  NamePriceCell.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

class NamePriceCell: UITableViewCell, NibLoadableView, ReusableView {

    var sWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var nameLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsLabelHeightConstraint: NSLayoutConstraint!
}

extension NamePriceCell {
    
    func configure(good: GoodDetailsModel) {
        
        nameLabel.text = good.name
        priceLabel.text = good.stringPrice
        detailsLabel.text = good.details
        ratingLabel.text = good.stringRatingAndReviews
        
        nameLabelHeightConstraint.constant = NamePriceCell.getLabelHeight(text: good.name, font: nameLabel.font, width: sWidth - 133)
        detailsLabelHeightConstraint.constant = NamePriceCell.getLabelHeight(text: good.details, font: detailsLabel.font, width: sWidth - 133)
        
        
        let reviewsColor = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1)
        let reviewsFont = UIFont(name: "Montserrat Medium", size: 9)!
        ratingLabel.changeColorAndFontOfPartText(good.stringReviews, color: reviewsColor, font: reviewsFont)
    }
    
    static func getLabelHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font]
        
        return text.boundingRect(with: size, options: options, attributes: attributes, context: nil).height + 10
    }
}
