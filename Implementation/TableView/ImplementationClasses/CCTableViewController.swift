//
//  CCTableViewController.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewPresenterViewInputProtocol: class {
    func configure(dataSource: Any?, delegate: Any?)
    func configurePagination(prefetchOutput: CCTableViewPrefetchOutputProtocol?)
    func configureRefresh()
    
    func reloadTableView()
    
    func insertCellsIntoTableView(at paths: [IndexPath])
    func removeCellsIntoTableView(at paths: [IndexPath])
    func reloadCellsIntoTableView(at paths: [IndexPath])
    
    func updateHieghtCell(at paths: [IndexPath])
}

protocol CCTableViewPrefetchOutputProtocol: class {
    func fetchList()
    func countList() -> Int
}

class CCTableViewController: UIViewController{
    
    //  MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: Properties
    
    var prefetchOutput: CCTableViewPrefetchOutputProtocol?
    
}

//  MARK: Lifecycle

extension CCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//  MARK: CCTableViewPresenterViewInputProtocol

extension CCTableViewController: CCTableViewPresenterViewInputProtocol {

    func configure(dataSource: Any?, delegate: Any?) {
        let dataSource  = (dataSource as? UITableViewDataSource)
        let delegate    = (delegate as? UITableViewDelegate)
        
        guard dataSource != nil && delegate != nil else {
            assertionFailure("CCTableViewController: dataSourse \(String(describing: dataSource)) or delegate \(String(describing: delegate))")
            return
        }
        
        self.tableView.dataSource           = dataSource
        self.tableView.delegate             = delegate
    }
    
    func configurePagination(prefetchOutput: CCTableViewPrefetchOutputProtocol?) {
        self.tableView.prefetchDataSource = self
        self.prefetchOutput = prefetchOutput
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
        
        guard let output = self.prefetchOutput else {
            return
        }
        
        if indexPaths.contains(where: { (indexPath) -> Bool in
            print(String(describing: indexPath.row) + "|" + String(describing: output.countList()))
            return indexPath.row >= (output.countList() - 1)
        }) {
            self.prefetchOutput?.fetchList()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
    
}
