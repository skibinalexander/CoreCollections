//
//  Manager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// swiftlint:disable all

class Manager<T: TemplateViewModels>: ManagerProtocol, TemplateViewModelsDataSource {
    
    // MARK: - Properties
    
    /// Шаблон конфигурации viewModels ячеек и секций коллекции
    var template: TemplateViewModels!
    
    /// DataSource закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    var dataSource: DataSourceProtocol!
    
    /// Delegate закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    var delegate: Delegate!
    
    /// View Layer закрытый абстрактным протоколом управлением конкретной реализацией (UITableView / UICollectionView)
    weak var containerView: ContainerViewInputProtocol!
    
    /// Data Layer закрытый абстрактным протоколом управления данными коллекции
    var containerData: ManagerContextProtocol!
    
    /// Delegate для сообщения events управления View Layer
    weak var viewDelegate: ManagerContextViewCallbackProtocol!
    
    /// Набор элементов коллекции для слоя model
    var items: [ItemModel] {
        get { return containerData.items }
        set { containerData?.items = newValue }
    }
    
    /// Свойство определяющее состояние refresing
    private var isRefreshing: Bool = false
    
    // MARK: - Setters
    
    func set(containerView: ContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    func set(containerData: ManagerContextProtocol?) {
        self.containerData = containerData
        self.containerData.set(template: template)
    }
    
    // MARK: - Getters
    
    func getDataSource() -> DataSourceProtocol? {
        return dataSource
    }
    
    func getDelegate() -> Delegate {
        return delegate
    }
    
    func getView() -> ContainerViewInputProtocol! {
        return containerView
    }
    
    func getData() -> ManagerContextProtocol {
        return containerData
    }
}

// MARK: - Refreshing

extension Manager {
    
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

extension Manager {
    
    func append(items: [ItemModel]) {
        self.items.append(contentsOf: items)
        template.reloadViewModelsItems()
    }
    
    func append(item: ItemModel) {
        self.items.append(item)
        template.reloadViewModelsItems()
    }
    
    func insert(item: ItemModel, at index: Int) {
        containerData.intert(item: item, at: index)
    }
    
    func replace(item: ItemModel) {
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
    
    func item(id: String?) -> ItemModel {
        return items.first(where: {$0.id == id })!
    }
    
    func item(index: Int) -> ItemModel {
        return items[index]
    }
    
    func item(type: ItemModel.Identifiers) -> ItemModel {
        return item(id: type.rawValue)
    }
    
}

// MARK: - Access to ViewModels

extension Manager {
    
    func updateHeightCell(id: String?, in item: ItemModel, by value: Float) {
        if let cell = item.cells.first(where: { $0?.id == id }) {
            containerView.updateHieghtCell { cell?.viewModel?.height = .value(value) }
        }
    }
    
    func updateHeightCell(id: String?, in type: ItemModel.Identifiers, by value: Float) {
        if let item = items.first(where: { $0.id == type.rawValue }) {
            updateHeightCell(id: id, in: item, by: value)
        }
    }
    
    func countItems() -> Int {
        return items.count
    }
    
    func isEmpty(in item: ItemModel) -> Bool {
        return item.cells.isEmpty
    }
    
}

// swiftlint:enable all
