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
    
    private var manager: CCManagerProtocol?
    private var containerData: CCManagerContextProtocol?
    private weak var containerView: CCContainerViewInputProtocol?
    private weak var prefetchOutput: CCContainerViewPrefetchOutputProtocol?
    private weak var refreshOutput: CCContainerViewRefreshOutputProtocol?
    
    final func configure(manager: CCManagerProtocol?) -> CCManagerBuilder {
        self.manager = manager
        return self
    }
    
    final func configure(containerView: CCContainerViewInputProtocol?) -> CCManagerBuilder {
        self.containerView = containerView
        return self
    }
    
    final func configure(containerData: CCManagerContextProtocol?) -> CCManagerBuilder {
        self.containerData = containerData
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
        containerView?.configure(dataSource: self.manager?.getDataSource(),
                                 delegate: self.manager?.getDelegate())
        containerView?.configurePagination(output: prefetchOutput)
        containerView?.configureRefresh(output: refreshOutput)
        
        manager?.set(containerView: containerView)
        manager?.set(containerData: containerData)
    }
    
}

// MARK: - CCManagerProtocol
protocol CCManagerProtocol: class {
    // MARK: - Setters
    func set(containerData: CCManagerContextProtocol?)
    func set(containerView: CCContainerViewInputProtocol?)
    
    // MARK: - Getters
    func getDataSource() -> CCDataSourceProtocol?
    func getDelegate() -> CCDelegateProtocol?
    func getView() -> CCContainerViewInputProtocol
    func getData() -> CCManagerContextProtocol
    
    func append(item: CCItemModel)
    func remove(item at: Int)
    func removeAll()
    
    func item(id: String?) -> CCItemModel
    func item(index: Int) -> CCItemModel
    func item(type: CCItemModel.Identifiers) -> CCItemModel
}

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsDataSource {
    // MARK: - Properties
    var template: CCTemplateViewModels?
    var dataSource: CCDataSourceProtocol?
    var delegate: CCDelegateProtocol?
    
    var containerView: CCContainerViewInputProtocol!
    var containerData: CCManagerContextProtocol!
    
    internal var items: [CCItemModel] = []
    
    // MARK: - Setters
    func set(containerView: CCContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    func set(containerData: CCManagerContextProtocol?) {
        self.containerData = containerData
        self.containerData.set(containerView: containerView)
        self.containerData.set(template: template)
        self.containerData.set(items: items)
    }
    
    // MARK: - Getters
    func getDataSource() -> CCDataSourceProtocol? {
        return dataSource
    }
    
    func getDelegate() -> CCDelegateProtocol? {
        return delegate
    }
    
    func getView() -> CCContainerViewInputProtocol {
        return containerView
    }
    
    func getData() -> CCManagerContextProtocol {
        return containerData
    }
}

extension CCManager {
    func append(item: CCItemModel) {
        items.append(item)
        template?.reloadViewModelsItems()
    }
    
    func remove(item at: Int) {
        items.remove(at: at)
        template?.reloadViewModelsItems()
    }
    
    func removeAll() {
        items.removeAll()
        template?.reloadViewModelsItems()
    }
    
    func item(id: String?) -> CCItemModel {
        return items.first(where: {$0.id == id })!
    }
    
    func item(index: Int) -> CCItemModel {
        return items[index]
    }
    
    func item(type: CCItemModel.Identifiers) -> CCItemModel {
        return item(id: type.rawValue)
    }
}
