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
    
    var tableViewOutput: CCTableViewControllerOutputProtocol?
    
}

//  MARK: Lifecycle

extension CCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//  MARK: CCTableViewPresenterViewInputProtocol

extension CCTableViewController: CCTableViewPresenterViewInputProtocol {

    func configure(dataSource: Any?, delegate: Any?, output: CCTableViewControllerOutputProtocol?) {
        let dataSource  = (dataSource as? UITableViewDataSource)
        let delegate    = (delegate as? UITableViewDelegate)
        
        guard dataSource != nil && delegate != nil else {
            assertionFailure("CCTableViewController: dataSourse \(String(describing: dataSource)) is nil or delegate \(String(describing: delegate)) is nil")
            return
        }
        
        self.tableView.dataSource           = dataSource
        self.tableView.delegate             = delegate
        self.tableView.prefetchDataSource   = self
        
        self.tableViewOutput = output
    }
    
    func configurePagination() {
//        self.tableView.prefetchDataSource = self
    }
    
    func configureRefresh() {
        
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func insertCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.insertRows(at: paths, with: .automatic)
    }
    
    func removeCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.deleteRows(at: paths, with: .automatic)
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
        
        guard let output = self.tableViewOutput else {
            return
        }
        
        if indexPaths.contains(where: { (indexPath) -> Bool in
            print(String(describing: indexPath.row) + "|" + String(describing: output.countList()))
            return indexPath.row >= (output.countList() - 1)
        }) {
            self.tableViewOutput?.fetchList()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
    
}
