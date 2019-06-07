//
//  CCTableViewController.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewController: UIViewController {
    
    //  MARK: IBOutlets
    
    @IBOutlet weak var tableView:   UITableView!
    private let refreshControl:     UIRefreshControl = UIRefreshControl()
    
    //  MARK: Properties
    
    private var prefetchOutput: CCContainerViewPrefetchOutputProtocol?
    
}

//  MARK: Lifecycle

extension CCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//  MARK: CCTableViewPresenterViewInputProtocol

extension CCTableViewController: CCContainerViewInputProtocol {

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
    
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?) {
        if output != nil {
            self.tableView.prefetchDataSource = self
            self.prefetchOutput = output
        }
    }
    
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?) {
        if output != nil {
            self.tableView.refreshControl = refreshControl
            self.refreshControl.addTarget(output!, action: #selector(CCContainerViewRefreshOutputProtocol.refreshTableView), for: .valueChanged)
        }
    }
    
    func reloadContainer() {
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
    
    func updateHieghtCell(completion: (()->Void)?) {
        if #available(iOS 11.0, *) {
            self.tableView.performBatchUpdates({
                completion?()
            }, completion: nil)
        } else {
            self.tableView.beginUpdates()
            completion?()
            self.tableView.endUpdates()
        }
    }
    
    func beginRefresing() {
        self.refreshControl.beginRefreshing()
    }
    
    func endRefresing() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
}

//  MARK: UITableViewDataSourcePrefetching

extension CCTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let output = self.prefetchOutput else {
            return
        }
        
        if indexPaths.contains(where: { (indexPath) -> Bool in
            return indexPath.row >= (output.numberRows(in: indexPath.section) - 1)
        }) {
            self.prefetchOutput?.batchList()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
    
}
