//
//  CCManagerContext+AddCells.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

extension CCManagerContext {
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType) {
        item.cells = cells
        template.reloadViewModelsCells()
        viewDelegate.didUpdateView(with: type)
    }
    
    func replaceCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            replaceCells(in: item, cells: cells, viewCallback: type)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }

    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol]) {
       item.cells.append(contentsOf: cells)
       template.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }

    func insertCells(in item: CCItemModel, cells: [CCModelCellProtocol], by position: Int) {
       if position >= 0 {
           item.cells.insert(contentsOf: cells, at: position)
           viewDelegate.didUpdateView(with: .insertIntoCollection, for: template.insertCells())
       } else {
           assertionFailure("CCManagerContext: Wrong index position")
       }
    }
    
    func insertCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            insertCells(in: item, cells: cells, by: position)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
}
