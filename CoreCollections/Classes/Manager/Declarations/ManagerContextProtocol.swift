//
//  ManagerContextProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Тип операции
public enum ManagerContenxtOperationType {
    
    /// Очистить
    case refresh
    
    /// Перезагрузить
    case reload
    
    /// Заменить
    case replace
    
    /// Вставить
    case insert
    
    /// Добавить
    case append
    
    /// Удалить
    case remove
    
}

public protocol ManagerContextProtocol: ManagerContextSettersProtocol, MapperViewModelsDataSource {
    
    /// Набор Item в текущем контексте коллекции
    var items: [ItemModel] { get set }
    
    // MARK: - Items Operations
    
    func operationAllItems(type: ManagerContenxtOperationType, viewCallback: ManagerContextViewCallbackType)
    
    // MARK: - Section Operations
    
    func refreshSectionsInAllItems()
    
    // MARK: - Cells Operations
    
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
    
    func refreshCellsInAllItems()
    func appendCells(in item: ItemModel, cells: [ModelCellProtocol])
    func insertCells(in item: ItemModel, cells:[ModelCellProtocol], by position: Int)
    func insertCells(in typeId: ItemModel.Identifiers, cells: [ModelCellProtocol], by position: Int)
    
    func removeCells(in item: ItemModel, at position: Int)
    func removeCells(in typeId: ItemModel.Identifiers, by position: Int)
    
    func removeAllCells(in item: ItemModel)
    func removeAllCells(in typeId: ItemModel.Identifiers)
}
