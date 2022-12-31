//
//  ListExampleView.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 28.02.2021.
//

import CoreCollections
import UIKit

final class ListExampleView: TableViewController {
    
    var presenter: ListExamplePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        tableView.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.className)
        
        presenter = ListExamplePresenter(view: self)
    }
    
}
