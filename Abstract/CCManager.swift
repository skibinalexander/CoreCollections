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
    
    final func configure(manager: CCManagerProtocol?) -> CCManagerBuilder {
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
        
        manager?.set(containerView: containerView)
        manager?.reloadAllCells()
    }
    
}

//  MARK: CCManager

protocol CCManagerProtocol: class {
    var isRefreshing: Bool  { get set }
    
    func set(containerView: CCContainerViewInputProtocol?)
    
    func getDataSource()    -> CCDataSourceProtocol?
    func getDelegate()      -> CCDelegateProtocol?
    
    func item(id: String?) -> CCItemModel?
    
    func append(item: CCItemModel)
    func remove(item at: Int)
    
    func countCells(in index: Int)    -> Int
    
    func modelCell(at indexPath: IndexPath)     -> CCModelProtocol?
    func modelHeader(at index: Int)             -> CCModelSectionProtocol?
    func modelFooter(at index: Int)             -> CCModelSectionProtocol?
    
    func reloadAllCells()
    func insertNewCells()
    
    func beginRefreshing()
    func endRefreshing()
    
}

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsDataSource {
    
    var containerView:  CCContainerViewInputProtocol?
    var template:       CCTemplateViewModels?
    var dataSource:     CCDataSourceProtocol?
    var delegate:       CCDelegateProtocol?
    
    var models:         [CCItemModel] = []
    
    var isRefreshing: Bool = false
    
    //
    
    func set(containerView: CCContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    //
    
    func getDataSource() -> CCDataSourceProtocol? {
        return dataSource
    }
    
    func getDelegate() -> CCDelegateProtocol? {
        return delegate
    }
    
}

extension CCManager {
    
    func append(item: CCItemModel) {
        self.models.append(item)
    }
    
    func remove(item at: Int) {
        self.models.remove(at: at)
    }
    
    func item(id: String?) -> CCItemModel? {
        return models.first(where: {$0.id == id })
    }
    
    func reloadAllCells() {
        template?.reloadViewModels()
    }
    
    func insertNewCells() {
        template?.insertCells()
    }
    
    func countCells(in index: Int) -> Int {
        return models[index].cells.count
    }
    
    func modelCell(at indexPath: IndexPath) -> CCModelProtocol? {
        return models[indexPath.section].cells[indexPath.row]
    }
    
    func modelHeader(at index: Int) -> CCModelSectionProtocol? {
        return models[index].header
    }
    
    func modelFooter(at index: Int) -> CCModelSectionProtocol? {
        return models[index].footer
    }
    
    func beginRefreshing() {
        isRefreshing = true
        containerView?.beginRefresing()
    }
    
    func endRefreshing() {
        isRefreshing = false
        containerView?.endRefresing()
    }
    
}

//  MARK: CCTemplateViewModelsHandlerProtocol

extension CCManager: CCTemplateViewModelsHandlerProtocol {
    
    func templateViewModelsDidReloadAll() {
        containerView?.reloadContainer()
        endRefreshing()
    }
    
    func templateViewModelsDidReload(paths: [IndexPath]) {
        
    }
    
    func templateViewModelsDidInserted(paths: [IndexPath]) {
        containerView?.insertCellsIntoTableView(at: paths)
        endRefreshing()
    }
    
    func templateViewModelsDidRemoved(paths: [IndexPath]) {
        
    }
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) {
        
    }
    
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) {
        
    }
    
}
