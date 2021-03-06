//
//  CCManagerContext+AddCells.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - Add Cells

extension CCManagerContext {
    
    /// Заменить ячейки в item
    ///
    /// Метод делает замену ячеек в item. UI делегат обновится с учетом переданного типа
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType) {
        item.cells = cells
        template.reloadViewModelsCells()
        viewDelegate.didUpdateView(with: type)
    }
    
    /// Заменить ячейки в item. Короткий метод поиска item по id
    ///
    /// Метод аналогичен replaceCells(in item: CCItemModel, удобен для использования item по id
    func replaceCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            replaceCells(in: item, cells: cells, viewCallback: type)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }

    /// Добавить ячейки в item в конец массива
    ///
    /// Метод добавляет ячейка в item массив ячеек в конец списка
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol]) {
       item.cells.append(contentsOf: cells)
       template.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }

    /// Добавить ячейки в item по индексу
    ///
    /// Метод добавляет ячейка в item по индексу
    func insertCells(in item: CCItemModel, cells: [CCModelCellProtocol], by position: Int) {
       if position >= 0 {
           item.cells.insert(contentsOf: cells, at: position)
           viewDelegate.didUpdateView(with: .insertIntoCollection, for: template.insertCells())
       } else {
           assertionFailure("CCManagerContext: Wrong index position")
       }
    }
    
    /// Добавить ячейки в item по индексу
    ///
    /// Метод аналогичен func insertCells(in item: CCItemModel, удобен при использовании item по id
    func insertCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            insertCells(in: item, cells: cells, by: position)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
}

// MARK: - Remove Cells

extension CCManagerContext {
    
    /// Удалить ячейки по индексу
    ///
    /// Удаляет ячейки из item по индексу. Обновление UI стандартное
    func removeCells(in item: CCItemModel, by position: Int) {
        item.cells.remove(at: position)
        viewDelegate.didUpdateView(with: .removeFromCollection, for: template.removeCells())
    }
    
    /// Удалить ячейки по индексу
    ///
    /// Удаляет ячейки из item по индексу. Обновление UI стандартное. Item используется по стандартному id
    func removeCells(in typeId: CCItemModel.Identifiers, by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            removeCells(in: item, by: position)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
    /// Удалить все ячейки
    ///
    /// Удаляет все ячейки из item по индексу. Обновление UI стандартное
    func removeAllCells(in item: CCItemModel) {
        guard item.cells.count > 0 else { return }
        item.cells.removeAll()
        viewDelegate.didUpdateView(with: .removeFromCollection, for: template.removeCells())
    }
    
    /// Удалить все ячейки
    ///
    /// Удаляет все ячейки из item по индексу. Обновление UI стандартное.  Item используется по стандартному id
    func removeAllCells(in typeId: CCItemModel.Identifiers) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            removeAllCells(in: item)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
}
