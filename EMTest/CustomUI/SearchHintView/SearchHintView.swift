//
//  SearchHintView.swift
//  EMTest
//
//  Created by Сергей Никитин on 17.03.2023.
//

import UIKit

protocol SearchHintViewDelegate {
    
    func select(_ hint: String)
    
}

final class SearchHintView: UIView {
    
    let maxElementsInResult = 7
    
    private var delegate: SearchHintViewDelegate!
    private var tableViewDelegate: SearchHintTableViewProtocol!
    
    private var parentView: UIView!
    private var tableView: UITableView!
    
    private var words: [String] = []
    
    private var parentFrame: CGRect {
        return parentView.frame
    }
    
    func setup(fromView view: UIView, withHints words: [String], delegate: SearchHintViewDelegate) {
        
        self.delegate = delegate
        self.parentView = view
        self.words = words
        
        setupInitialView()
        setupTableView()
    }
    
    private func setupInitialView() {
        
        guard words.count > 0 else { return }
        guard let superView = parentView.superview else { return }
        
        let height: CGFloat = words.count > maxElementsInResult ? CGFloat(maxElementsInResult * 40) : CGFloat(words.count * 40)
        self.frame = CGRect(x: parentFrame.minX, y: -height + 10, width: parentFrame.width, height: height)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor(red: 0.678, green: 0.678, blue: 0.678, alpha: 0.6).cgColor
        self.backgroundColor = UIColor(red: 0.961, green: 0.965, blue: 0.969, alpha: 1)
        
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOpacity = 0.6
        
        superView.addSubview(self)
    }
    
    private func setupTableView() {
        
        let frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        tableView = UITableView(frame: frame)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.bounces = false
        self.addSubview(tableView)
        
        tableViewDelegate = SearchHintTableViewDelegate(dataSource: words, tableView: tableView, delegate: delegate)
        tableViewDelegate.reloadData()
    }
    
    func show(animated: Bool = true, completion: (() -> (Void))? = nil) {
        let top = parentFrame.maxY + 10
        let bounds = self.frame
        
        guard animated else {
            self.frame = CGRect(x: bounds.minX, y: top, width: bounds.width, height: bounds.height)
            completion?()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: bounds.minX, y: top, width: bounds.width, height: bounds.height)
            self.layoutSubviews()
        }, completion: { _ in
            completion?()
        })
    }
    
    func hide(animated: Bool = false, completion: (() -> (Void))? = nil) {
        let bounds = self.frame
        
        guard animated else {
            self.frame = CGRect(x: bounds.minX, y: -bounds.height, width: bounds.width, height: bounds.height)
            self.removeFromSuperview()
            completion?()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: bounds.minX, y: -bounds.height, width: bounds.width, height: bounds.height)
            self.layoutSubviews()
        }, completion: { _ in
            self.removeFromSuperview()
            completion?()
        })
    }
}
