//
//  ManagerProtocol.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - ManagerContextViewCallbackProtocol

public protocol ManagerContextViewCallbackProtocol: AnyObject {
    func didUpdateView(with type: ManagerContextViewCallbackType)
    func didUpdateView(with type: ManagerContextViewCallbackType, for paths: [IndexPath])
}

// MARK: - ManagerProtocol

public protocol ManagerProtocol: AnyObject {
    
    /// Конфигурация менеджера
    func configuration()
    
    // MARK: - Setters
    
    func set(template: TemplateViewModelsProtocol)
    func set(containerData: ManagerContextProtocol?)
    func set(containerView: ContainerViewInputProtocol?)
    
    // MARK: - Getters
    
    func getDataSource() -> DataSource?
    func getDelegate() -> Delegate
    func getView() -> ContainerViewInputProtocol!
    func getData() -> ManagerContextProtocol
    
    // - Access to Refresh control flow
    func beginRefresh()
    func endRefresh()
    
    /// - Items
    func item(id: String?) -> ItemModel
    func item(index: Int) -> ItemModel
    func item(type: ItemModel.Identifiers) -> ItemModel
    
    // - Access to ViewModels
    
    /// Найти первую view model ячейки по id во всех items
    /// - Parameter id: Идентификатор ячейки
    /// 
    /// Warning: вернется первая ячейка во всех item найденному по id. Быть внимательными если исполузуются одинаковые id для ячеек
    func viewModelCell<M: ViewModelCellProtocol>(id: String?) -> M?
    
    /// Найти view model ячейки по id в item
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: item коллекции
    func viewModelCell<M: ViewModelCellProtocol>(id: String?, in item: ItemModel) -> M?
    
    /// Найти view model ячейки по id в item
    /// - Parameters:
    ///   - id: Индекс ячейки
    ///   - item: item коллекции
    func viewModelCell<M: ViewModelCellProtocol>(index: Int, in item: ItemModel) -> M?
    
    /// Найти view model ячейки по id в item
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: item по заданному типу
    func viewModelCell<M: ViewModelCellProtocol>(id: String?, in type: ItemModel.Identifiers) -> M?
    
    /// Найти view model заголовка item
    /// - Parameter item: item коллекции
    func viewModelHeader<M: ViewModelSectionProtocol>(in item: ItemModel) -> M?
    
    
    /// Метод обновления высоты ячейки
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: Item коллекции
    ///   - value: Значение высоты
    func updateHeightCell(id: String?, in item: ItemModel, by value: Float)
    
    /// Метод обновления высоты ячейки
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: Item коллекции по заданному типу
    ///   - value: Значение высоты
    func updateHeightCell(id: String?, in type: ItemModel.Identifiers, by value: Float)
    
}
