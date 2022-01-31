//
//  TableViewController.swift
//  OpenSource
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 SkibinAlexander. All rights reserved.
//

import UIKit

open class TableViewController: UIViewController, ContainerViewInputProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet
    public weak var tableView: UITableView!
    
    // MARK: - Properties
    public let refreshControl: UIRefreshControl = UIRefreshControl()
    
    private weak var refreshOutput: ContainerViewRefreshOutputProtocol?
    private weak var prefetchOutput: ContainerViewPrefetchOutputProtocol?
    
    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshControl.endRefreshing()
    }
    
    // MARK: - CCTableViewPresenterViewInputProtocol
    
    public func configure(dataSource: Any?, delegate: Any?) {
        let dataSource  = (dataSource as? UITableViewDataSource)
        let delegate    = (delegate as? UITableViewDelegate)
        
        guard dataSource != nil && delegate != nil else {
            assertionFailure("CCTableViewController: dataSourse \(String(describing: dataSource)) or delegate \(String(describing: delegate))")
            return
        }
        
        self.tableView?.dataSource = dataSource
        self.tableView?.delegate = delegate
    }
    
    public func configurePagination(output: ContainerViewPrefetchOutputProtocol?) {
        if output != nil {
            self.tableView.prefetchDataSource = self
            self.prefetchOutput = output
        }
    }
    
    public func configureRefresh(output: ContainerViewRefreshOutputProtocol?) {
        if output != nil {
            self.tableView.refreshControl = refreshControl
            self.refreshOutput = output
            self.refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        }
    }
    
    public func reloadContainer() {
        self.tableView?.reloadData()
    }
    
    public func insertCells(at paths: [IndexPath]) {
        self.tableView.insertRows(at: paths, with: .automatic)
    }
    
    public func removeCells(at paths: [IndexPath]) {
        self.tableView.deleteRows(at: paths, with: .automatic)
    }
    
    public func reloadCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.reloadRows(at: paths, with: .automatic)
    }
    
    public func updateHieghtCell(completion: (() -> Void)?) {
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
    
    public func beginRefreshing() {
        self.refreshControl.beginRefreshing()
    }
    
    public func endRefreshing() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    public func isEditing(_ editing: Bool) {
        tableView.isEditing = editing
    }
    
    // MARK: - Refreshing
    
    @objc
    open func refreshAction() {
        refreshOutput?.refreshList()
    }
    
}

// MARK: - UITableViewDataSourcePrefetching

extension TableViewController: UITableViewDataSourcePrefetching {
    
    open func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let output = self.prefetchOutput else { return }
        output.batchOfPaths(paths: indexPaths)
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {}
    
}
