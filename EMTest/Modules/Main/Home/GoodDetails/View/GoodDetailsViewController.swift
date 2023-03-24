//
//  GoodDetailsViewController.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

class GoodDetailsViewController: UIViewController {

    var viewModel: GoodDetailsViewModelDelegate!
    var tableViewDelegate: DetailsSectionProtocol!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cartPanel: CartPanel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailsSection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCartPanel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideCartPanel()
    }
    
    @IBAction func backButtonAction() {
        viewModel.backToPreviousPage()
    }
    
    func hideCartPanel(animated: Bool = true, completion: (() -> (Void))? = nil) {
        guard cartPanel.tag == 1 else { return }
        
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: { [weak self] in
            guard let self = self else { return }
            self.bottomConstraint.constant = self.cartPanel.bounds.height / 2
            self.view.layoutSubviews()
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.cartPanel.tag = 0
            completion?()
        })
    }
    
    func showCartPanel(animated: Bool = true, completion: (() -> (Void))? = nil) {
        guard cartPanel.tag == 0 else { return }
        
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: { [weak self] in
            guard let self = self else { return }
            self.cartPanel.reloadData()
            self.bottomConstraint.constant = 0.0
            self.view.layoutSubviews()
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.cartPanel.good = self.viewModel.currentGood()
            self.cartPanel.tag = 1
            completion?()
        })
    }
    
    func setupDetailsSection() {
        tableViewDelegate = DetailsSectionDelegate(tableView: tableView, viewModel: viewModel)
        tableViewDelegate.reloadData()
    }
    
}
