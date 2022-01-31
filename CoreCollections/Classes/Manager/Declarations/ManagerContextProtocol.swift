//
//  ManagerContextProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public protocol ManagerContextProtocol:
    AnyObject,
    ManagerContextSettersProtocol,
    ManagerContextItemsProtocol {
    
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
    
    func removeCells(in item: ItemModel, at position: Int)
    func removeCells(in typeId: ItemModel.Identifiers, by position: Int)
    
    func removeAllCells(in item: ItemModel)
    func removeAllCells(in typeId: ItemModel.Identifiers)
}
