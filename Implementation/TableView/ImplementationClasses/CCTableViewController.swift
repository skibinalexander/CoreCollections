//
//  CCTableViewController.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewController: UIViewController, CCContainerViewInputProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    private weak var refreshOutput: CCContainerViewRefreshOutputProtocol?
    private weak var prefetchOutput: CCContainerViewPrefetchOutputProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshControl.endRefreshing()
    }
    
    // MARK: - CCTableViewPresenterViewInputProtocol
    
    func configure(dataSource: Any?, delegate: Any?) {
        let dataSource  = (dataSource as? UITableViewDataSource)
        let delegate    = (delegate as? UITableViewDelegate)
        
        guard dataSource != nil && delegate != nil else {
            assertionFailure("CCTableViewController: dataSourse \(String(describing: dataSource)) or delegate \(String(describing: delegate))")
            return
        }
        
        self.tableView?.dataSource = dataSource
        self.tableView?.delegate = delegate
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
            self.refreshOutput = output
            self.refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        }
    }
    
    func reloadContainer() {
        self.tableView?.reloadData()
    }
    
    func insertCells(at paths: [IndexPath]) {
        self.tableView.insertRows(at: paths, with: .automatic)
    }
    
    func removeCells(at paths: [IndexPath]) {
        self.tableView.deleteRows(at: paths, with: .automatic)
    }
    
    func reloadCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.reloadRows(at: paths, with: .automatic)
    }
    
    func updateHieghtCell(completion: (() -> Void)?) {
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
    
    // MARK: - Refreshing
    
    @objc func refreshAction() {
        refreshOutput?.refreshList()
    }
    
}

// MARK: - UITableViewDataSourcePrefetching

extension CCTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let output = self.prefetchOutput else { return }
        if indexPaths.contains(where: { $0.row >= (output.batchNumberRows(in: $0.section) - 2) }) {
            self.prefetchOutput?.batchList()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {}
}
