//
//  DetailsSectionDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 16.03.2023.
//

import UIKit

protocol DetailsSectionProtocol: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var good: GoodDetailsModel { get }
    
    var viewModel: GoodDetailsViewModelDelegate { get }
    
    var tableView: UITableView { get }
    
    func reloadData()
}

class DetailsSectionDelegate: NSObject, DetailsSectionProtocol {
    
    var good: GoodDetailsModel
    
    var viewModel: GoodDetailsViewModelDelegate
    
    var tableView: UITableView
    
    init(tableView: UITableView, viewModel: GoodDetailsViewModelDelegate) {
        
        self.good = viewModel.currentGood()
        self.viewModel = viewModel
        self.tableView = tableView
        
        self.tableView.register(NamePriceCell.self)
        self.tableView.register(SelectColorCell.self)
        self.tableView.register(SelectImageCell.self)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return good.imageURLs.count > 0 ? 370.0 : 0.0
        case 1:
            let width = UIScreen.main.bounds.width - 133
            let nameFont = UIFont(name: "Montserrat Bold", size: 16)!
            let detailsFont = UIFont(name: "Montserrat Medium", size: 10)!
            
            let nameHeight = NamePriceCell.getLabelHeight(text: good.name, font: nameFont, width: width)
            let detailsHeight = NamePriceCell.getLabelHeight(text: good.details, font: detailsFont, width: width)
            
            return 40.0 + nameHeight + detailsHeight
        case 2:
            return good.colors.count > 0 ? 60.0 : 0.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard good.imageURLs.count > 0 else { return UITableViewCell() }
            let cell: SelectImageCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.viewModel = viewModel
            cell.configure(model: good)
            return cell
        case 1:
            let cell: NamePriceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(good: good)
            return cell
        case 2:
            guard good.colors.count > 0 else { return UITableViewCell() }
            
            let cell: SelectColorCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.viewModel = viewModel
            cell.configure(colors: good.colors)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
