//
//  CCTableViewController.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewControllerOutputProtocol: class {
    func fetchList()
    func countList() -> Int
}

class CCTableViewController: UIViewController{
    
    //  MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: Properties
    
    var output: CCTableViewControllerOutputProtocol?
    
}

//  MARK: Lifecycle

extension CCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//  MARK: CCTableViewPresenterViewInputProtocol

extension CCTableViewController: CCTableViewPresenterViewInputProtocol {
    
    func configure(dataSource: Any, delegate: Any) {
        let dataSource  = (dataSource as? UITableViewDataSource)
        let delegate    = (delegate as? UITableViewDelegate)
        
        guard dataSource != nil && delegate != nil else {
            assertionFailure("CCTableViewController: dataSourse \(String(describing: dataSource)) is nil or delegate \(String(describing: delegate)) is nil")
            return
        }
        
        self.tableView.dataSource   = dataSource
        self.tableView.delegate     = delegate
    }
    
    func configurePagination() {
        self.tableView.prefetchDataSource = self
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

//  MARK: UITableViewDataSourcePrefetching

extension CCTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let output = self.output else {
            return
        }
        
        let _ = indexPaths.map({ (indexPath) in
            if indexPath.row >= output.countList() {
                output.fetchList()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
    
}
