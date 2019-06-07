//
//  CCManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: CCManagerBuilder

class CCManagerBuilder {
    
    static let shared: CCManagerBuilder = CCManagerBuilder()
    
    private weak var manager:           CCManagerProtocol?
    private weak var containerView:     CCContainerViewInputProtocol?
    private weak var prefetchOutput:    CCContainerViewPrefetchOutputProtocol?
    private weak var refreshOutput:     CCContainerViewRefreshOutputProtocol?
    
    final func configure(manager: CCManagerProtocol) -> CCManagerBuilder {
        self.manager = manager
        return self
    }
    
    final func configure(containerView: CCContainerViewInputProtocol?) -> CCManagerBuilder {
        self.containerView = containerView
        return self
    }
    
    final func configure(prefetch output: CCContainerViewPrefetchOutputProtocol?) -> CCManagerBuilder {
        self.prefetchOutput = output
        return self
    }
    
    final func configure(refresh output: CCContainerViewRefreshOutputProtocol?) -> CCManagerBuilder {
        self.refreshOutput = output
        return self
    }
    
    final func build() {
        containerView?.configure(dataSource: self.manager?.getDataSource(), delegate: self.manager?.getDelegate())
        containerView?.configurePagination(output: prefetchOutput)
        containerView?.configureRefresh(output: refreshOutput)
        containerView?.reloadContainer()
    }
    
}

//  MARK: CCManager

protocol CCManagerProtocol: class {
    func getDataSource()    -> CCDataSourceProtocol?
    func getDelegate()      -> CCTableViewDelegateProtocol?
    
    func append(item: CCItemModel)
    func remove(item at: Int)
    
    func countCells(in index: Int)    -> Int
    
    func modelCell(at indexPath: IndexPath)     -> CCModelProtocol?
    func modelHeader(at index: Int)             -> CCModelSectionProtocol?
    func modelFooter(at index: Int)             -> CCModelSectionProtocol?
    
    func beginRefreshing()
    func endRefreshing()
}

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsHandlerProtocol {
    
    var containerView:  CCTableViewPresenterViewInputProtocol?
    var dataSource:     CCDataSourceProtocol?
    var delegate:       CCTableViewDelegateProtocol?
    
    func getDataSource() -> CCDataSourceProtocol? {
        return self.dataSource
    }
    
    func getDelegate() -> CCTableViewDelegateProtocol? {
        return self.delegate
    }
    
}

extension CCManager {
    
    func append(item: CCItemModel) {
        self.dataSource?.models.append(item)
    }
    
    func remove(item at: Int) {
        self.dataSource?.models.remove(at: at)
    }
    
    func countCells(in index: Int) -> Int {
        return dataSource?.models[index].cells.count ?? 0
    }
    
    func modelCell(at indexPath: IndexPath) -> CCModelProtocol? {
        return dataSource?.models[indexPath.section].cells[indexPath.row]
    }
    
    func modelHeader(at index: Int) -> CCModelSectionProtocol? {
        return dataSource?.models[index].header
    }
    
    func modelFooter(at index: Int) -> CCModelSectionProtocol? {
        return dataSource?.models[index].footer
    }
    
    func beginRefreshing() {
        
    }
    
    func endRefreshing() {
        
    }
    
}

extension CCManager {
    
    func templateViewModelsDidReload(paths: [IndexPath]) {
        
    }
    
    func templateViewModelsDidInserted(paths: [IndexPath]) {
        
    }
    
    func templateViewModelsDidRemoved(paths: [IndexPath]) {
        
    }
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) {
        
    }
    
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) {
        
    }
    
}
