//
//  HomeViewController.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModelDelegate!
    
    var tableViewDelegate: ContentSectionProtocol!
    var collectionViewDelegate: CategoryCellProtocol!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: CustomSearchTextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchHintView: SearchHintView?
    var timerManager = TimerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupSearchView()
        setupCategorySection()
        
        updateContentSection()
        updateBottomConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserIcon()
    }
    
    func updateBottomConstraints() {
        guard let navigationController = self.navigationController else { return }
        guard let tabbarController = navigationController.tabBarController as? MainTabBarController else { return }
        
        bottomConstraint.constant = 4 + tabbarController.tabbarDifference
    }
    
    func setupUserIcon() {
        userIconImageView.image = nil
        
        viewModel.getUserIcon { [weak self] image in
            guard let self = self else { return }
            
            self.userIconImageView.layer.cornerRadius = 16
            self.userIconImageView.layer.borderWidth = 0.8
            self.userIconImageView.layer.borderColor = UIColor(red: 0.357, green: 0.357, blue: 0.357, alpha: 1).cgColor
            self.userIconImageView.image = image
        }
        
    }
    
    func setupSearchView() {
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 12
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setupTitleLabel() {
        let changeText = "bata"
        let changeColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)
        titleLabel.changeColorOfPartText(changeText, color: changeColor)
    }
    
    func setupCategorySection() {
        collectionViewDelegate = CategoryCellDelegate(dataSource: CategoryCellModel.allCases,
                                                      collectionView: collectionView, viewModel: viewModel)
        collectionViewDelegate.reloadData()
    }
    
    func updateContentSection() {
        showLoading()
        viewModel.getHomeContent(success: { [weak self] latest, flash in
            guard let self = self else { return }
            
            self.tableViewDelegate = ContentSectionDelegate(latest: latest, flash: flash,
                                                            tableView: self.tableView, viewModel: self.viewModel)
            self.tableViewDelegate.reloadData()
            self.hideLoading()
            
        }, failure: { [weak self] message in
            
            guard let self = self else { return }
            
            self.hideLoading()
            self.showAttentionMessage(message, completion: {})
        })
        
    }
    
    @IBAction func menuButtonAction() {
        menuButton.viewTouched {
            
        }
    }
    
    @IBAction func locationButtonAction() {
        locationButton.viewTouched {
            
        }
    }
    
    @IBAction func stopSearching() {
        hideKeyboard()
        timerManager.finish()
        searchTextField.text = nil
        
        searchHintView?.hide { [weak self] in
            guard let self = self else { return }
            self.searchHintView = nil
        }
            
    }

}

extension HomeViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        timerManager.finish()
        
        guard textField == searchTextField else { return }
        guard let text = textField.text, !text.isEmpty else {
            searchHintView?.hide()
            return
        }
        
        timerManager.setManagerDelegate(with: self, andHint: text)
        timerManager.start()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard textField == searchTextField else { return false }
        guard let text = textField.text, !text.isEmpty else { return false }
        
        timerManager.finish()
        searchText(text)
        
        return true
    }
}

extension HomeViewController: SearchHintViewDelegate {
    
    func select(_ hint: String) {
        
        searchHintView?.hide { [weak self] in
            guard let self = self else { return }
            
            self.hideKeyboard()
            self.searchHintView = nil
            self.searchTextField.text = hint
        }
    }
}

extension HomeViewController: TimerManagerProtocol {
    
    func searchText(_ text: String) {
        viewModel.searchGoods(forText: text, completion: { [weak self] words in
            guard let self = self else { return }
            
            guard words.count > 0 else {
                self.searchHintView?.hide()
                return
            }
            
            if let searchHintView = self.searchHintView {
                searchHintView.hide {
                    self.searchHintView = SearchHintView()
                    self.searchHintView?.setup(fromView: self.searchView, withHints: words, delegate: self)
                    self.searchHintView?.show(animated: false)
                }
            } else {
                self.searchHintView = SearchHintView()
                self.searchHintView?.setup(fromView: self.searchView, withHints: words, delegate: self)
                self.searchHintView?.show()
            }
        })
    }
}
