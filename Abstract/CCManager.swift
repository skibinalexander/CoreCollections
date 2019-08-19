//
//  CCManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - CCManagerBuilder

class CCManagerBuilder {
    
    static func shared() -> CCManagerBuilder {
        return CCManagerBuilder()
    }
    
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
        manager?.refreshCells()
    }
    
}

// MARK: - CCManager

enum CCManagerCellsAddType {
    case replace(reload: Bool)          //  Replace and is Bool reload All
    case append(reload: Bool)           //  Append and is Bool reload All
    case insert(index: Int)     //  Insert and reload empty view models
}

protocol CCManagerCellsProtocol: class {
    func refreshCells()
    func reloadCells()
    func addCells(in item: CCItemModel, type: CCManagerCellsAddType, cells: [CCModelCellProtocol])
}

protocol CCManagerProtocol: CCManagerCellsProtocol {
    var isRefreshing: Bool { get set }
    
    func set(containerView: CCContainerViewInputProtocol?)
    
    func getDataSource() -> CCDataSourceProtocol?
    func getDelegate() -> CCDelegateProtocol?
    
    func item(index: Int) -> CCItemModel?
    func item(id: String?) -> CCItemModel?
    
    func append(item: CCItemModel)
    func remove(item at: Int)
    
    func countCells(in index: Int) -> Int
    
    func modelCell(at indexPath: IndexPath) -> CCModelProtocol?
    func modelCell(at id: String, in item: CCItemModel) -> CCModelProtocol?
    func modelHeader(at index: Int) -> CCModelSectionProtocol?
    func modelFooter(at index: Int) -> CCModelSectionProtocol?
    
    func beginRefreshing()
    func endRefreshing()
}

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsDataSource {
    
    var containerView: CCContainerViewInputProtocol?
    var template: CCTemplateViewModels?
    var dataSource: CCDataSourceProtocol?
    var dataHandler: CCDelegateProtocol?
    
    internal var models: [CCItemModel] = []
    
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
        return dataHandler
    }
    
}

extension CCManager {
    
    func append(item: CCItemModel) {
        self.models.append(item)
    }
    
    func remove(item at: Int) {
        self.models.remove(at: at)
    }
    
    func item(index: Int) -> CCItemModel? {
        if models.count > index {
            return models[index]
        }
        
        return nil
    }
    
    func item(id: String?) -> CCItemModel? {
        return models.first(where: {$0.id == id })
    }
    
    func countCells(in index: Int) -> Int {
        return models[index].cells.count
    }
    
    func modelCell(at indexPath: IndexPath) -> CCModelProtocol? {
        return models[indexPath.section].cells[indexPath.row]
    }
    
    func modelCell(at id: String, in item: CCItemModel) -> CCModelProtocol? {
        let cell = item.cells.first { (model) -> Bool in
            return model?.id == id
        } as? CCModelProtocol
        
        return cell
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

extension CCManager {
    
    func refreshCells() {
        models.forEach({$0.cells = []})
        template?.reloadViewModels()
    }
    
    func reloadCells() {
        template?.reloadViewModels()
    }
    
    func addCells(in item: CCItemModel, type: CCManagerCellsAddType, cells: [CCModelCellProtocol]) {
        switch type {
        case .replace(let isReload):
            item.cells = cells
            if isReload { template?.reloadViewModels() }
        case .append(let isReload):
            item.cells.append(contentsOf: cells)
            if isReload { template?.reloadViewModels() }
        case .insert(let index):
            item.cells.insert(contentsOf: cells, at: index)
            template?.insertCells()
            
        }
    }
    
}

// MARK: - CCTemplateViewModelsHandlerProtocol

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
    
}
