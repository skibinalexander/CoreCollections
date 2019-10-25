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
        manager?.set(context: CCContextCell.instance())
    }
    
}

// MARK: - CCManager

enum CCManagerReloadType {
    case none
    case all
    case item
}

enum CCManagerChangeType {
    case reload
    case refresh
    case replace(reload: CCManagerReloadType)   //  Replace and is Bool reload All
    case append(reload: CCManagerReloadType)    //  Append and is Bool reload All
    case insert(index: Int)                     //  Insert and reload empty view items
    case top
    case bottom
}

protocol CCManagerCellsContextProtocol: class {
    func set(template: CCTemplateViewModels?)
    func set(containerView: CCContainerViewInputProtocol?)
    func set(items: [CCItemModel]?)
    
    func item(id: String?) -> CCItemModel?
    func item(index: Int) -> CCItemModel?
    func item(type: CCItemModel.Identifiers) -> CCItemModel?
    
    func refresh()
    func change(item: CCItemModel?, type: CCManagerChangeType, cells: [CCModelCellProtocol], _ error: (() -> Void)?)
    func change(itemId: String?, type: CCManagerChangeType, cells: [CCModelCellProtocol], error: (() -> Void)?)
    func change(itemType: CCItemModel.Identifiers, type: CCManagerChangeType, cells: [CCModelCellProtocol], error: (() -> Void)?)
}

protocol CCManagerProtocol: class {
    // MARK: - Setters
    func set(context: CCManagerCellsContextProtocol?)
    func set(containerView: CCContainerViewInputProtocol?)
    
    // MARK: - Getters
    func getContext() -> CCManagerCellsContextProtocol
    func getDataSource() -> CCDataSourceProtocol?
    func getDelegate() -> CCDelegateProtocol?
    
    func append(item: CCItemModel)
    func remove(item at: Int)
    
    func modelCell(at indexPath: IndexPath) -> CCModelProtocol?
    func modelCell(at id: String, in item: CCItemModel) -> CCModelProtocol?
    func modelHeader(at index: Int) -> CCModelSectionProtocol?
    func modelFooter(at index: Int) -> CCModelSectionProtocol?
}

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsDataSource {
    var context: CCManagerCellsContextProtocol!
    var containerView: CCContainerViewInputProtocol?
    var template: CCTemplateViewModels?
    var dataSource: CCDataSourceProtocol?
    var dataHandler: CCDelegateProtocol?
    
    internal var items: [CCItemModel] = []

    func set(containerView: CCContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    func set(context: CCManagerCellsContextProtocol?) {
        self.context = context
        self.context?.set(containerView: containerView)
        self.context?.set(template: template)
        self.context?.set(items: items)
    }
    
    func getContext() -> CCManagerCellsContextProtocol { return context }
    func getDataSource() -> CCDataSourceProtocol? { return dataSource }
    func getDelegate() -> CCDelegateProtocol? { return dataHandler }
}

extension CCManager {
    func append(item: CCItemModel) {
        self.items.append(item)
        self.context?.set(items: items)
    }
    func remove(item at: Int) {
        self.items.remove(at: at)
        self.context?.set(items: items)
    }

    func modelCell(at indexPath: IndexPath) -> CCModelProtocol? {
        return items[indexPath.section].cells[indexPath.row]
    }
    
    func modelCell(at id: String, in item: CCItemModel) -> CCModelProtocol? {
        let cell = item.cells.first { (model) -> Bool in
            return model?.id == id
        } as? CCModelProtocol
        
        return cell
    }
    
    func modelHeader(at index: Int) -> CCModelSectionProtocol? { return items[index].header }
    func modelFooter(at index: Int) -> CCModelSectionProtocol? { return items[index].footer }
}

// MARK: - CCTemplateViewModelsHandlerProtocol

extension CCManager: CCTemplateViewModelsHandlerProtocol {
    func templateViewModelsDidReloadAll() {
        containerView?.reloadContainer()
        containerView?.endRefresing()
    }
    
    func templateViewModelsDidReload(in sections: [Int]) {
        containerView?.reloadCells(in: sections)
        containerView?.endRefresing()
    }
    
    func templateViewModelsDidInserted(paths: [IndexPath]) {
        containerView?.insertCells(at: paths)
        containerView?.endRefresing()
    }
    
    func templateViewModelsDidRemoved(paths: [IndexPath]) {
        
    }
}

class CCContextCell: CCManagerCellsContextProtocol {
    // MARK: - Static
    static func instance() -> CCManagerCellsContextProtocol {
        return CCContextCell()
    }
    
    // MARK: - Properties
    private weak var template: CCTemplateViewModels?
    private weak var containerView: CCContainerViewInputProtocol?
    private var items: [CCItemModel]?
    
    // MARK: - Setters
    func set(template: CCTemplateViewModels?) {
        self.template = template
    }
    
    func set(containerView: CCContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    func set(items: [CCItemModel]?) {
        self.items = items
    }
    
    // MARK: - CCManagerCellsContextProtocol
    func refresh() {
        containerView?.beginRefresing()
        items?.forEach({$0.cells = []})
        template?.reloadViewModels()
    }
    
    func change(item: CCItemModel? = nil, type: CCManagerChangeType, cells: [CCModelCellProtocol] = [], _ error: (() -> Void)? = nil) {
        switch type {
        case .replace(let reloadType):
            if let item = item {
                item.cells = cells
                reloadItem(with: reloadType, forIn: item)
            } else { error?() }
        case .append(let reloadType):
            if let item = item {
                item.cells.append(contentsOf: cells)
                reloadItem(with: reloadType, forIn: item)
            } else { error?() }
        case .insert(let index):
            if let item = item {
                item.cells.insert(contentsOf: cells, at: index)
                template?.insertCells()
            } else { error?() }
        case .refresh:
            containerView?.beginRefresing()
            items?.forEach({$0.cells = []})
            template?.reloadViewModels()
        case .reload:
            template?.reloadViewModels()
        case .top:
            if let item = item {
                item.cells.insert(contentsOf: cells, at: 0)
                template?.insertCells()
            } else { error?() }
        case .bottom:
            if let item = item {
                item.cells.insert(contentsOf: cells, at: item.cells.count)
                template?.insertCells()
            } else { error?() }
        }
    }
    
    func change(itemId: String?, type: CCManagerChangeType, cells: [CCModelCellProtocol], error: (() -> Void)? = nil) {
        if let item = item(id: itemId) {
            change(item: item, type: type, cells: cells)
        } else {
            error?()
        }
    }
    
    func change(itemType: CCItemModel.Identifiers, type: CCManagerChangeType, cells: [CCModelCellProtocol], error: (() -> Void)? = nil) {
        if let item = item(id: itemType.rawValue) {
            change(item: item, type: type, cells: cells)
        } else {
            error?()
        }
    }
    
    private func reloadItem(with type: CCManagerReloadType, forIn item: CCItemModel) {
        switch type {
        case .none: break
        case .all: template?.reloadViewModels()
        case .item:
            if let index = items?.firstIndex(where: {$0 == item}) { template?.reloadViewModels(in: index) }
        }
    }
    
    func item(id: String?) -> CCItemModel? {
        return items?.first(where: {$0.id == id })
    }
    
    func item(index: Int) -> CCItemModel? {
        if items?.count ?? -1 > index { return items?[index] }
        return nil
    }
    
    func item(type: CCItemModel.Identifiers) -> CCItemModel? {
        return item(id: type.rawValue)
    }
}
