//
//  CCTableViewController.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewController: UIViewController{
    
    //  MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
}

//  MARK: Lifecycle

extension CCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//  MARK: CCTableViewPresenterViewInputProtocol

extension CCTableViewController: CCTableViewPresenterViewInputProtocol {
    
    func configure(dataSource: CCTableViewDataSource<CCTemplateViewModels>, delegate: CCTableViewDelegate) {
        self.tableView.dataSource   = dataSource
        self.tableView.delegate     = delegate
    }
    
    func configurePagination() {
        
    }
    
    func configureRefresh() {
        
    }
    
    func reloadTableView() {
        
    }
    
    func insertCellsIntoTableView(at paths: [IndexPath]) {
        
    }
    
    func removeCellsIntoTableView(at paths: [IndexPath]) {
        
    }
    
    func reloadCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.reloadRows(at: paths, with: .automatic)
    }
    
    func updateHieghtCell(at paths: [IndexPath]) {
        
    }
    
}
