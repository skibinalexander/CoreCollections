//
//  Manager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// swiftlint:disable all

open class Manager<T: TemplateViewModels>: ManagerProtocol, TemplateViewModelsDataSource {
    
    // MARK: - Properties
    
    /// Шаблон конфигурации viewModels ячеек и секций коллекции
    var template: TemplateViewModels!
    
    /// DataSource закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    var dataSource: DataSource!
    
    /// Delegate закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    var delegate: Delegate!
    
    /// View Layer закрытый абстрактным протоколом управлением конкретной реализацией (UITableView / UICollectionView)
    weak var containerView: ContainerViewInputProtocol!
    
    /// Data Layer закрытый абстрактным протоколом управления данными коллекции
    var containerData: ManagerContextProtocol!
    
    /// Delegate для сообщения events управления View Layer
    weak var viewDelegate: ManagerContextViewCallbackProtocol!
    
    /// Набор элементов коллекции для слоя model
    public var items: [ItemModel] {
        get { return containerData.items }
        set { containerData?.items = newValue }
    }
    
    /// Свойство определяющее состояние refresing
    internal var isRefreshing: Bool = false
    
    // MARK: - Setters
    
    public func set(containerView: ContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    public func set(containerData: ManagerContextProtocol?) {
        self.containerData = containerData
        self.containerData.set(template: template)
    }
    
    // MARK: - Getters
    
    public func getDataSource() -> DataSource? {
        return dataSource
    }
    
    public func getDelegate() -> Delegate {
        return delegate
    }
    
    public func getView() -> ContainerViewInputProtocol! {
        return containerView
    }
    
    public func getData() -> ManagerContextProtocol {
        return containerData
    }
    
}

// swiftlint:enable all
