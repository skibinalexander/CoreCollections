//
//  CCManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// swiftlint:disable all

class CCManager<T: CCTemplateViewModels>: CCManagerProtocol, CCTemplateViewModelsDataSource {
    
    // MARK: - Properties
    
    /// Шаблон конфигурации viewModels ячеек и секций коллекции
    var template: CCTemplateViewModels!
    
    /// DataSource закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    var dataSource: CCDataSourceProtocol!
    
    /// Delegate закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    var delegate: CCDelegate!
    
    /// View Layer закрытый абстрактным протоколом управлением конкретной реализацией (UITableView / UICollectionView)
    weak var containerView: CCContainerViewInputProtocol!
    
    /// Data Layer закрытый абстрактным протоколом управления данными коллекции
    var containerData: CCManagerContextProtocol!
    
    /// Delegate для сообщения events управления View Layer
    weak var viewDelegate: CCManagerContextViewCallbackProtocol!
    
    /// Набор элементов коллекции для слоя model
    var items: [CCItemModel] {
        get { return containerData.items }
        set { containerData?.items = newValue }
    }
    
    /// Свойство определяющее состояние refresing
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
    
    func getView() -> CCContainerViewInputProtocol! {
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
        getView()?.beginRefreshing()
        isRefreshing = true
    }
    
    func endRefresh() {
        getView()?.endRefreshing()
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
    
    func updateHeightCell(id: String?, in item: CCItemModel, by value: Float) {
        if let cell = item.cells.first(where: { $0?.id == id }) {
            containerView.updateHieghtCell { cell?.viewModel?.height = .value(value) }
        }
    }
    
    func updateHeightCell(id: String?, in type: CCItemModel.Identifiers, by value: Float) {
        if let item = items.first(where: { $0.id == type.rawValue }) {
            updateHeightCell(id: id, in: item, by: value)
        }
    }
    
    func countItems() -> Int {
        return items.count
    }
    
    func isEmpty(in item: CCItemModel) -> Bool {
        return item.cells.isEmpty
    }
    
}

// swiftlint:enable all
