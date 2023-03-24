//
//  ProfileCellModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

enum ProfileCellModel: String, CaseIterable {
    
    case tradeStore = "Trade store"
    case paymentMethod = "Payment method"
    case balance = "Balance"
    case tradeHistory = "Trade history"
    case restorePurchase = "Restore purchase"
    case helpCell = "Help"
    case logOut = "Log out"
    
    var type: ProfileCellTypeEnum {
        switch self {
        case .balance:
            return .balance
        case .tradeStore, .paymentMethod, .tradeHistory, .restorePurchase:
            return .disclosure
        case .helpCell, .logOut:
            return .simple
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .tradeStore, .paymentMethod, .tradeHistory, .balance:
            return UIImage(named: "general-icon")
        case .restorePurchase:
            return UIImage(named: "restore-icon")
        case .helpCell:
            return UIImage(named: "help-icon")
        case .logOut:
            return UIImage(named: "logout-icon")
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .tradeStore, .paymentMethod, .tradeHistory, .balance, .restorePurchase:
            return 65
        default:
            return 60
        }
    }
}
