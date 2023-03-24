//
//  UIViewController+extension.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

extension UIViewController {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    @IBAction func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func showAttentionMessage(_ message: String, completion: @escaping () -> (Void)) {
        showErrorMessage("Attention!", message, completion: completion)
    }
    
    func showErrorMessage(_ title: String?, _ message: String, completion: @escaping () -> (Void)) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.overrideUserInterfaceStyle = .light
            
            let action = UIAlertAction.init(title: "OK", style: .cancel) { action in
                completion()
            }
            alert.addAction(action)
        
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        LoadingViewController().showLoading(view: self.view)
    }
    
    func hideLoading() {
        LoadingViewController().hideLoading()
    }
}
