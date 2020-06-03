//
//  CCManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// swiftlint:disable all

// MARK: - CCManagerBuilder
class CCManagerBuilder {
    // MARK: - Static
    static func shared() -> CCManagerBuilder {
        return CCManagerBuilder()
    }
    
    // MARK: - Private Properties
    private var manager: CCManagerProtocol?
    private var containerData: CCManagerContextProtocol?
    private weak var containerView: CCContainerViewInputProtocol?
    private weak var viewDelegate: CCManagerContextViewCallbackProtocol?
    private weak var prefetchOutput: CCContainerViewPrefetchOutputProtocol?
    private weak var refreshOutput: CCContainerViewRefreshOutputProtocol?
    private var items: [CCItemModel] = []
    
    // MARK: - Configure
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
    
    final func configure(viewDelegate: CCManagerContextViewCallbackProtocol?) -> CCManagerBuilder {
        self.viewDelegate = viewDelegate
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
    
    final func configure(items: [CCItemModel]) -> CCManagerBuilder {
        self.items.append(contentsOf: items)
        return self
    }
    
    // MARK: - Build
    final func build() {
        containerData?.set(viewDelegate: self.viewDelegate)
        
        containerView?.configure(dataSource: self.manager?.getDataSource(), delegate: self.manager?.getDelegate())
        containerView?.configurePagination(output: prefetchOutput)
        containerView?.configureRefresh(output: refreshOutput)
        
        manager?.set(containerView: containerView)
        manager?.set(containerData: containerData)
        
        manager?.append(items: self.items)
    }
    
}

// MARK: - CCManagerProtocol
protocol CCManagerProtocol: class {
    // MARK: - Setters
    func set(containerData: CCManagerContextProtocol?)
    func set(containerView: CCContainerViewInputProtocol?)
    
    // MARK: - Getters
    func getDataSource() -> CCDataSourceProtocol?
    func getDelegate() -> CCDelegate
    func getView() -> CCContainerViewInputProtocol
    func getData() -> CCManagerContextProtocol
    
    // - Access to Refresh control flow
    func beginRefresh()
    func endRefresh()
    
    //  - Access to items
    func append(items: [CCItemModel])
    func append(item: CCItemModel)
    func replace(item: CCItemModel)
    func remove(item at: Int)
    func removeAll()
    
    func item(id: String?) -> CCItemModel
    func item(index: Int) -> CCItemModel
    func item(type: CCItemModel.Identifiers) -> CCItemModel
    
    // - Access to ViewModels
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in item: CCItemModel) -> M?
    func viewModelCell<M: CCViewModelCellProtocol>(index: Int, in item: CCItemModel) -> M?
    func viewModelHeader<M: CCViewModelSectionProtocol>(in item: CCItemModel) -> M?
    
    func countItems() -> Int
    func isEmpty(in item: CCItemModel) -> Bool
}

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsDataSource {
    // MARK: - Properties
    var template: CCTemplateViewModels!
    var dataSource: CCDataSourceProtocol!
    var delegate: CCDelegate!
    
    var containerView: CCContainerViewInputProtocol!
    var containerData: CCManagerContextProtocol!
    var viewDelegate: CCManagerContextViewCallbackProtocol!
    
    var items: [CCItemModel] {
        get { return containerData.items }
        set { containerData?.items = newValue }
    }
    
    private var isRefreshing: Bool = false
    
    // MARK: - Setters
    func set(containerView: CCContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    func set(containerData: CCManagerContextProtocol?) {
        self.containerData = containerData
        self.containerData.set(template: template)
    }
    
    // MARK: - Getters
    func getDataSource() -> CCDataSourceProtocol? {
        return dataSource
    }
    
    func getDelegate() -> CCDelegate {
        return delegate
    }
    
    func getView() -> CCContainerViewInputProtocol {
        return containerView
    }
    
    func getData() -> CCManagerContextProtocol {
        return containerData
    }
}

// MARK: - Refreshing
extension CCManager {
    func beginRefresh() {
        getData().refreshAllInAllItems()
        getView().beginRefresing()
        isRefreshing = true
    }
    
    func endRefresh() {
        getView().endRefresing()
        isRefreshing = false
    }
    
}

// MARK: -
extension CCManager {
    
    func append(items: [CCItemModel]) {
        self.items.append(contentsOf: items)
        template.reloadViewModelsItems()
    }
    
    func append(item: CCItemModel) {
        self.items.append(item)
        template.reloadViewModelsItems()
    }
    
    func insert(item: CCItemModel, at index: Int) {
        containerData.intert(item: item, at: index)
    }
    
    func replace(item: CCItemModel) {
        if let replaceIndex = items.firstIndex(where: { return item.id == $0.id }) {
            items[replaceIndex].cells = item.cells
            template.reloadViewModelsCells()
        } else {
            items.append(item)
            template.reloadViewModelsItems()
        }
    }
    
    func remove(item at: Int) {
        items.remove(at: at)
        getData().set(items: items)
        template.reloadViewModelsItems()
    }
    
    func removeAll() {
        items.removeAll()
        template.reloadViewModelsItems()
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

// MARK: - Access to ViewModels
extension CCManager {
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in item: CCItemModel) -> M? {
        let cells = template.viewModels.first(where: { $0.id == item.id })?.cells
        return cells?.first(where: { $0?.getModel.id == id }) as? M
    }
    
    func viewModelCell<M: CCViewModelCellProtocol>(index: Int, in item: CCItemModel) -> M? {
        let cells = template.viewModels.first(where: { $0.id == item.id })?.cells
        return cells?[index] as? M
    }
    
    func viewModelHeader<M: CCViewModelSectionProtocol>(in item: CCItemModel) -> M? {
        return template.viewModels.first(where: { $0.id == item.id })?.header as? M
    }
    
    func countItems() -> Int {
        return items.count
    }
    
    func isEmpty(in item: CCItemModel) -> Bool {
        return item.cells.isEmpty
    }
}

// swiftlint:enable all
