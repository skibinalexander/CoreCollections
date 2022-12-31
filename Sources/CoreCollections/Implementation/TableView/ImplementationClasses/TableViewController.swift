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
    public var tableView: UITableView!
    
    // MARK: - Properties
    public let refreshControl: UIRefreshControl = UIRefreshControl()
    
    private weak var output: ContainerViewOutputProtocol?
    
    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshControl.endRefreshing()
    }
    
    // MARK: - CCTableViewPresenterViewInputProtocol
    
    public func configure(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.tableView?.dataSource = dataSource
        self.tableView?.delegate = delegate
    }
    
    public func configure(output: ContainerViewOutputProtocol?) {
        if output != nil {
            self.output = output
            
            self.tableView.prefetchDataSource = self
            self.tableView.refreshControl = refreshControl
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
        output?.refreshList()
    }
    
}

// MARK: - UITableViewDataSourcePrefetching

extension TableViewController: UITableViewDataSourcePrefetching {
    
    open func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let output = self.output else { return }
        output.batchOfPaths(paths: indexPaths)
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {}
    
}
