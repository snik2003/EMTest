//
//  ProfileCellDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

protocol ProfileCellProtocol: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource: [ProfileCellModel] { get set }
    
    var viewModel: ProfileViewModelDelegate { get set }
    
    var tableView: UITableView { get set }
    
    func reloadData()
}

class ProfileCellDelegate: NSObject, ProfileCellProtocol {
    
    var dataSource: [ProfileCellModel]
    
    var viewModel: ProfileViewModelDelegate
    
    var tableView: UITableView
    
    init(dataSource: [ProfileCellModel], tableView: UITableView, viewModel: ProfileViewModelDelegate) {
        
        self.dataSource = dataSource
        self.viewModel = viewModel
        self.tableView = tableView
        
        self.tableView.register(ProfileCell.self)
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel
        cell.configure(model: dataSource[indexPath.row])
        return cell
    }
}
