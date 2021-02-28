//
//  Manager+Actions.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public extension Manager {
    
    func updateHeightCell(id: String?, in item: ItemModel, by value: Float) {
        if let cell = item.cells.first(where: { $0?.id == id }) {
            containerView.updateHieghtCell { cell?.viewModel?.height = .value(value) }
        }
    }
    
    func updateHeightCell(id: String?, in type: ItemModel.Identifiers, by value: Float) {
        if let item = items.first(where: { $0.id == type.rawValue }) {
            updateHeightCell(id: id, in: item, by: value)
        }
    }
    
    func countItems() -> Int {
        items.count
    }
    
    func isEmpty(in item: ItemModel) -> Bool {
        item.cells.isEmpty
    }
    
}
