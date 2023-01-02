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
    
    // MARK: - Public Properties
    
    public let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Private Properties
    
    private weak var output: ContainerViewOutputProtocol?
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Configurations
    
    open func configuration() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    // MARK: - TableViewPresenterViewInputProtocol
    
    public func resolveCollectionView<V>() -> V {
        tableView as! V
    }
    
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
    
    public func updateHieghtCell(_ completion: (() -> Void)?) {
        self.tableView.beginUpdates()
        completion?()
        self.tableView.endUpdates()
    }
    
    public func isEditing(_ editing: Bool) {
        tableView.isEditing = editing
    }
    
    // MARK: - Refreshing
    
    public func beginRefreshing() {
        self.refreshControl.beginRefreshing()
    }
    
    public func endRefreshing() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
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
    
    open func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {}
    
}
