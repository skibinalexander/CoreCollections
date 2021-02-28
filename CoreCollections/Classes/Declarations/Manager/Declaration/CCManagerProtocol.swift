//
//  ManagerProtocol.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - ManagerContextViewCallbackProtocol

public protocol ManagerContextViewCallbackProtocol: class {
    func didUpdateView(with type: ManagerContextViewCallbackType)
    func didUpdateView(with type: ManagerContextViewCallbackType, for paths: [IndexPath])
}

// MARK: - ManagerProtocol

protocol ManagerProtocol: class {
    
    // MARK: - Setters
    
    func set(containerData: ManagerContextProtocol?)
    func set(containerView: ContainerViewInputProtocol?)
    
    // MARK: - Getters
    
    func getDataSource() -> DataSourceProtocol?
    func getDelegate() -> Delegate
    func getView() -> ContainerViewInputProtocol!
    func getData() -> ManagerContextProtocol
    
    // - Access to Refresh control flow
    func beginRefresh()
    func endRefresh()
    
    //  - Access to items
    func append(items: [ItemModel])
    func append(item: ItemModel)
    func replace(item: ItemModel)
    func remove(item at: Int)
    func removeAll()
    
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
    
    /// Количество items в коллекции
    func countItems() -> Int
    
    
    /// Проверка заполненности item ячейками
    /// - Parameter item: Item коллекции
    func isEmpty(in item: ItemModel) -> Bool
}

// MARK: - ManagerContextProtocol

public protocol ManagerContextSettersProtocol {
    func set(viewDelegate: ManagerContextViewCallbackProtocol)
    func set(template: TemplateViewModels)
    func set(items: [ItemModel])
}

public protocol ManagerContextItemsProtocol {
    func append(item: ItemModel)
    func intert(item: ItemModel, at index: Int)
    func remove(item: ItemModel, at index: Int)
}

public protocol ManagerContextProtocol: class, ManagerContextSettersProtocol, ManagerContextItemsProtocol {
    var items: [ItemModel] { get set }
    
    func isEmpty() -> Bool
    
    func refreshAllItems()
    func reloadAllInAllItems(viewCallback type: ManagerContextViewCallbackType)
    func refreshAllInAllItems()
    func refreshCellsInAllItems()
    func refreshSectionsInAllItems()
    
    func replaceCells(
        in item: ItemModel,
        cells: [ModelCellProtocol],
        viewCallback type: ManagerContextViewCallbackType
    )
    
    func replaceCells(
        in typeId: ItemModel.Identifiers,
        cells: [ModelCellProtocol],
        viewCallback type: ManagerContextViewCallbackType
    )
    
    func appendCells(in item: ItemModel, cells: [ModelCellProtocol])
    func insertCells(in item: ItemModel, cells:[ModelCellProtocol], by position: Int)
    func insertCells(in typeId: ItemModel.Identifiers, cells: [ModelCellProtocol], by position: Int)
    
    func removeCells(in item: ItemModel, by position: Int)
    func removeCells(in typeId: ItemModel.Identifiers, by position: Int)
    
    func removeAllCells(in item: ItemModel)
    func removeAllCells(in typeId: ItemModel.Identifiers)
}
