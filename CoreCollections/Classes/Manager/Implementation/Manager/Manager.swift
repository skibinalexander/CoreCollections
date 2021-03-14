//
//  Manager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// swiftlint:disable all

open class Manager: ManagerProtocol, MapperViewModelsDataSource {
    
    // MARK: - Properties
    
    /// Шаблон конфигурации viewModels ячеек и секций коллекции
    internal var template: TemplateViewModelsProtocol!
    
    /// Маппер конфигурации viewModels ячеек и секций коллекции
    internal var mapper: MapperViewModels!
    
    /// DataSource закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    private var dataSource: DataSource
    
    /// Delegate закрытый абстрактным протоколом для коллекции конкретной реализации (UITableView / UICollectionView)
    private var delegate: Delegate
    
    /// Delegate для сообщения events управления View Layer
    weak var viewDelegate: ManagerContextViewCallbackProtocol!
    
    // MARK: - Injection Properties
    
    /// View Layer закрытый абстрактным протоколом управлением конкретной реализацией (UITableView / UICollectionView)
    public weak var containerView: ContainerViewInputProtocol!
    
    /// Data Layer закрытый абстрактным протоколом управления данными коллекции
    public var containerData: ManagerContextProtocol!
    
    /// Набор элементов коллекции для слоя model
    public var items: [ItemModel] {
        get { return containerData.items }
        set { containerData?.items = newValue }
    }
    
    /// Свойство определяющее состояние refresing
    internal var isRefreshing: Bool = false
    
    // MARK: - Initialization
    
    init(
        dataSource: DataSource,
        delegate: Delegate,
        viewDelegate: ManagerContextViewCallbackProtocol
    ) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.viewDelegate = viewDelegate
    }
    
    public func configuration() {
        self.mapper = MapperViewModels(template: self.template)
        mapper.dataSource = self
        dataSource.mapper = mapper
        delegate.mapper = mapper
    }
    
    // MARK: - Setters
    
    public func set(template: TemplateViewModelsProtocol) {
        self.template = template
    }
    
    public func set(containerView: ContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    public func set(containerData: ManagerContextProtocol?) {
        self.containerData = containerData
        self.containerData.set(mapper: mapper)
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
