//
//  CCManagerContext+RemoveCells.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

extension CCManagerContext {
    func removeCells(in item: CCItemModel, by position: Int) {
        item.cells.remove(at: position)
        viewDelegate.didUpdateView(with: .removeFromCollection, for: template.removeCells())
    }
    
    func removeCells(in typeId: CCItemModel.Identifiers, by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            removeCells(in: item, by: position)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
    func removeAllCells(in item: CCItemModel) {
        guard item.cells.count > 0 else { return }
        item.cells.removeAll()
        viewDelegate.didUpdateView(with: .removeFromCollection, for: template.removeCells())
    }
    
    func removeAllCells(in typeId: CCItemModel.Identifiers) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            guard item.cells.count > 0 else { return }
            removeCells(in: item, by: 0)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
}
