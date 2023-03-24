//
//  UIView+extension.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

extension UIView {
    
    func viewTouched(duration: TimeInterval = 0.15, completion: @escaping () -> (Void)) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.96)
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { _ in
                completion()
            })
        })
    }
    
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func showLoading() {
        LoadingViewController().showLoading(view: self, height: 25, alpha: 0.0)
    }
    
    func hideLoading() {
        LoadingViewController().hideLoading()
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
}
