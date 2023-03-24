//
//  MainTabBarController.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let tabbarHeight: CGFloat = 84
        
    private lazy var defaultTabBarHeight = { [unowned self] in
        return self.tabBar.frame.size.height
    }()
        
    var tabbarDifference: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeHeight()
        changeDesign()
    }
    
    func changeHeight() {
        tabbarDifference = tabbarHeight - defaultTabBarHeight
        
        var newFrame = tabBar.frame
        newFrame.size.height = tabbarHeight
        newFrame.origin.y = view.frame.size.height - tabbarHeight

        tabBar.frame = newFrame
            
        tabBar.items?.forEach({ item in
            item.selectedImage = UIImage(named: "tabbar\(item.tag)-selected")
            item.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
        })
    }
        
    func changeDesign() {
        view.backgroundColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .clear
        
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        tabBar.layer.shadowRadius = 30
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        tabBar.layer.shadowOpacity = 1
        
        view.layoutIfNeeded()
    }
}
