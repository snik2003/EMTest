//
//  SearchHintTableViewDelegate.swift
//  EMTest
//
//  Created by Сергей Никитин on 17.03.2023.
//

import UIKit

protocol SearchHintTableViewProtocol: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource: [String] { get }
    
    var tableView: UITableView { get }
    
    var searchHintViewDelegate: SearchHintViewDelegate { get }
    
    func reloadData()
    
}

class SearchHintTableViewDelegate: NSObject, SearchHintTableViewProtocol {
    
    var dataSource: [String]
    
    var tableView: UITableView
    
    var searchHintViewDelegate: SearchHintViewDelegate
    
    init(dataSource: [String], tableView: UITableView, delegate: SearchHintViewDelegate) {
        
        self.tableView = tableView
        self.dataSource = dataSource
        self.searchHintViewDelegate = delegate
        
        self.tableView.register(SearchHintCell.self)
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchHintCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = searchHintViewDelegate
        cell.configure(hint: dataSource[indexPath.row])
        return cell
    }
    
}
