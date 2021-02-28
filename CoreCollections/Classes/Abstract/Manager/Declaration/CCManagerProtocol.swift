//
//  CCManagerProtocol.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - CCManagerContextViewCallbackProtocol

protocol CCManagerContextViewCallbackProtocol: class {
    func didUpdateView(with type: CCManagerContextViewCallbackType)
    func didUpdateView(with type: CCManagerContextViewCallbackType, for paths: [IndexPath])
}

// MARK: - CCManagerProtocol

protocol CCManagerProtocol: class {
    
    // MARK: - Setters
    
    func set(containerData: CCManagerContextProtocol?)
    func set(containerView: CCContainerViewInputProtocol?)
    
    // MARK: - Getters
    
    func getDataSource() -> CCDataSourceProtocol?
    func getDelegate() -> CCDelegate
    func getView() -> CCContainerViewInputProtocol!
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
    
    /// Найти первую view model ячейки по id во всех items
    /// - Parameter id: Идентификатор ячейки
    /// 
    /// Warning: вернется первая ячейка во всех item найденному по id. Быть внимательными если исполузуются одинаковые id для ячеек
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?) -> M?
    
    /// Найти view model ячейки по id в item
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: item коллекции
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in item: CCItemModel) -> M?
    
    /// Найти view model ячейки по id в item
    /// - Parameters:
    ///   - id: Индекс ячейки
    ///   - item: item коллекции
    func viewModelCell<M: CCViewModelCellProtocol>(index: Int, in item: CCItemModel) -> M?
    
    /// Найти view model ячейки по id в item
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: item по заданному типу
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in type: CCItemModel.Identifiers) -> M?
    
    /// Найти view model заголовка item
    /// - Parameter item: item коллекции
    func viewModelHeader<M: CCViewModelSectionProtocol>(in item: CCItemModel) -> M?
    
    
    /// Метод обновления высоты ячейки
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: Item коллекции
    ///   - value: Значение высоты
    func updateHeightCell(id: String?, in item: CCItemModel, by value: Float)
    
    /// Метод обновления высоты ячейки
    /// - Parameters:
    ///   - id: Идентификатор ячейки
    ///   - item: Item коллекции по заданному типу
    ///   - value: Значение высоты
    func updateHeightCell(id: String?, in type: CCItemModel.Identifiers, by value: Float)
    
    /// Количество items в коллекции
    func countItems() -> Int
    
    
    /// Проверка заполненности item ячейками
    /// - Parameter item: Item коллекции
    func isEmpty(in item: CCItemModel) -> Bool
}

// MARK: - CCManagerContextProtocol

protocol CCManagerContextSettersProtocol {
    func set(viewDelegate: CCManagerContextViewCallbackProtocol)
    func set(template: CCTemplateViewModels)
    func set(items: [CCItemModel])
}

protocol CCManagerContextItemsProtocol {
    func append(item: CCItemModel)
    func intert(item: CCItemModel, at index: Int)
    func remove(item: CCItemModel, at index: Int)
}

protocol CCManagerContextProtocol: class, CCManagerContextSettersProtocol, CCManagerContextItemsProtocol {
    var items: [CCItemModel] { get set }
    
    func isEmpty() -> Bool
    
    func refreshAllItems()
    func reloadAllInAllItems(viewCallback type: CCManagerContextViewCallbackType)
    func refreshAllInAllItems()
    func refreshCellsInAllItems()
    func refreshSectionsInAllItems()
    
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType)
    func replaceCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType)
    
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol])
    func insertCells(in item: CCItemModel, cells:[CCModelCellProtocol], by position: Int)
    func insertCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], by position: Int)
    
    func removeCells(in item: CCItemModel, by position: Int)
    func removeCells(in typeId: CCItemModel.Identifiers, by position: Int)
    
    func removeAllCells(in item: CCItemModel)
    func removeAllCells(in typeId: CCItemModel.Identifiers)
}
