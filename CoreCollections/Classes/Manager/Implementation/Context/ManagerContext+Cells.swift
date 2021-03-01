//
//  ManagerContext+AddCells.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - Add Cells

public extension ManagerContext {
    
    /// Заменить ячейки в item
    ///
    /// Метод делает замену ячеек в item. UI делегат обновится с учетом переданного типа
    func replaceCells(in item: ItemModel, cells: [ModelCellProtocol], viewCallback type: ManagerContextViewCallbackType) {
        item.cells = cells
        mapper.reloadViewModelsCells()
        viewDelegate.didUpdateView(with: type)
    }
    
    /// Заменить ячейки в item. Короткий метод поиска item по id
    ///
    /// Метод аналогичен replaceCells(in item: ItemModel, удобен для использования item по id
    func replaceCells(in typeId: ItemModel.Identifiers, cells: [ModelCellProtocol], viewCallback type: ManagerContextViewCallbackType) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            replaceCells(in: item, cells: cells, viewCallback: type)
        } else {
            assertionFailure("ManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }

    /// Добавить ячейки в item в конец массива
    ///
    /// Метод добавляет ячейка в item массив ячеек в конец списка
    func appendCells(in item: ItemModel, cells: [ModelCellProtocol]) {
       item.cells.append(contentsOf: cells)
       mapper.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }

    /// Добавить ячейки в item по индексу
    ///
    /// Метод добавляет ячейка в item по индексу
    func insertCells(in item: ItemModel, cells: [ModelCellProtocol], by position: Int) {
       if position >= 0 {
           item.cells.insert(contentsOf: cells, at: position)
           viewDelegate.didUpdateView(with: .insertIntoCollection, for: mapper.insertCells())
       } else {
           assertionFailure("ManagerContext: Wrong index position")
       }
    }
    
    /// Добавить ячейки в item по индексу
    ///
    /// Метод аналогичен func insertCells(in item: ItemModel, удобен при использовании item по id
    func insertCells(in typeId: ItemModel.Identifiers, cells: [ModelCellProtocol], by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            insertCells(in: item, cells: cells, by: position)
        } else {
            assertionFailure("ManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
}

// MARK: - Remove Cells

public extension ManagerContext {
    
    /// Удалить ячейки по индексу
    ///
    /// Удаляет ячейки из item по индексу. Обновление UI стандартное
    func removeCells(in item: ItemModel, by position: Int) {
        item.cells.remove(at: position)
        viewDelegate.didUpdateView(with: .removeFromCollection, for: mapper.removeCells())
    }
    
    /// Удалить ячейки по индексу
    ///
    /// Удаляет ячейки из item по индексу. Обновление UI стандартное. Item используется по стандартному id
    func removeCells(in typeId: ItemModel.Identifiers, by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            removeCells(in: item, by: position)
        } else {
            assertionFailure("ManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
    /// Удалить все ячейки
    ///
    /// Удаляет все ячейки из item по индексу. Обновление UI стандартное
    func removeAllCells(in item: ItemModel) {
        guard item.cells.count > 0 else { return }
        item.cells.removeAll()
        viewDelegate.didUpdateView(with: .removeFromCollection, for: mapper.removeCells())
    }
    
    /// Удалить все ячейки
    ///
    /// Удаляет все ячейки из item по индексу. Обновление UI стандартное.  Item используется по стандартному id
    func removeAllCells(in typeId: ItemModel.Identifiers) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            removeAllCells(in: item)
        } else {
            assertionFailure("ManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
}
