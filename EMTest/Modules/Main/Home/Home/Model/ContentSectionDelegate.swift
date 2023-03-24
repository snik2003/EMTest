//
//  ContentSectionDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 15.03.2023.
//

import UIKit

protocol ContentSectionProtocol: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var latestDataSource: [LatestGoodModel] { get }
    
    var flashDataSource: [FlashSaleModel] { get }
    
    var viewModel: HomeViewModelDelegate { get set }
    
    var tableView: UITableView { get set }
    
    func reloadData()
    
}

class ContentSectionDelegate: NSObject, ContentSectionProtocol {
    
    var latestDataSource: [LatestGoodModel]
    
    var flashDataSource: [FlashSaleModel]
    
    var viewModel: HomeViewModelDelegate
    
    var tableView: UITableView
    
    init(latest: [LatestGoodModel], flash: [FlashSaleModel], tableView: UITableView, viewModel: HomeViewModelDelegate) {
        
        self.latestDataSource = latest
        self.flashDataSource = flash
        
        self.viewModel = viewModel
        self.tableView = tableView
        
        self.tableView.register(FlashContentCell.self)
        self.tableView.register(LatestContentCell.self)
    }
    
    func reloadData() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return latestDataSource.count > 0 ? 190 : 0
        case 1:
            return flashDataSource.count > 0 ? 265 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard latestDataSource.count > 0 else { return UITableViewCell() }
            
            let cell: LatestContentCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.viewModel = viewModel
            cell.configure(dataSource: latestDataSource)
            return cell
        case 1:
            guard flashDataSource.count > 0 else { return UITableViewCell() }
            
            let cell: FlashContentCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.viewModel = viewModel
            cell.configure(dataSource: flashDataSource)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
