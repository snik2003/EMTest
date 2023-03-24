//
//  LoadingViewController.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

class LoadingViewController {
    
    private static var container: UIView = UIView()
    
    private static var loadingView: UIImageView = UIImageView()
    
    func showLoading(view: UIView, height: CGFloat = 50, alpha: CGFloat = 0.2) {
        OperationQueue.main.addOperation {
            LoadingViewController.container.frame = view.frame
            LoadingViewController.container.center = view.center
            LoadingViewController.container.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            LoadingViewController.loadingView.tintColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
            LoadingViewController.loadingView.frame = CGRect(x: 0, y: 0, width: height, height: height)
            LoadingViewController.loadingView.image = UIImage(named: "loading")
            LoadingViewController.loadingView.clipsToBounds = true
            LoadingViewController.loadingView.center = view.center
            LoadingViewController.loadingView.rotate()
        
            LoadingViewController.container.addSubview(LoadingViewController.loadingView)
            view.addSubview(LoadingViewController.container)
        }
    }
    
    func hideLoading() {
        OperationQueue.main.addOperation {
            LoadingViewController.container.removeFromSuperview()
        }
    }
}
