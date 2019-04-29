//
//  CCTableViewBuilderPresenter.swift
//  PaginationTableView
//
//  Created by Пользователь on 29/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCTableViewBuilderPresenter {
    
    static let shared: CCTableViewBuilderPresenter = CCTableViewBuilderPresenter()
    
    private weak var presenter:         CCTableViewPresenterProtocol?
    private weak var tableView:         CCTableViewPresenterViewInputProtocol?
    private weak var dataSource:        AnyObject?
    private weak var delegate:          AnyObject?
    private weak var prefetchOutput:    CCTableViewPrefetchOutputProtocol?
    private weak var refreshOutput:     CCTableViewRefreshOutputProtocol?
    
    final func configure(presenter: CCTableViewPresenterProtocol) -> CCTableViewBuilderPresenter {
        self.presenter = presenter
        return self
    }
    
    final func configure(tableView: CCTableViewPresenterViewInputProtocol?) -> CCTableViewBuilderPresenter {
        self.tableView = tableView
        return self
    }
    
    final func configure(dataSource: AnyObject?) -> CCTableViewBuilderPresenter {
        self.dataSource = dataSource
        return self
    }
    
    final func configure(delegate: AnyObject?) -> CCTableViewBuilderPresenter {
        self.delegate = delegate
        return self
    }
    
    final func configure(prefetch output: CCTableViewPrefetchOutputProtocol?) -> CCTableViewBuilderPresenter {
        self.prefetchOutput = output
        return self
    }
    
    final func configure(refresh output: CCTableViewRefreshOutputProtocol?) -> CCTableViewBuilderPresenter {
        self.refreshOutput = output
        return self
    }
    
    final func build() {
        self.tableView?.configure(dataSource: self.dataSource, delegate: self.delegate)
        tableView?.configure(dataSource: dataSource, delegate: delegate)
        tableView?.configurePagination(output: prefetchOutput)
        tableView?.configureRefresh(output: refreshOutput)
        presenter?.tableViewInput = tableView
    }
    
//    final func configurePagination() -> CCTableViewPresenter {
//        self.tableViewInput?.configurePagination()
//        return self
//    }
//
//    final func configureRefresh() -> CCTableViewPresenter {
//        self.tableViewInput?.configureRefresh()
//        return self
//    }
    
}
