//
//  Manager+Items.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public extension Manager {
    
    func append(items: [ItemModel]) {
        self.items.append(contentsOf: items)
        template.reloadViewModelsItems()
    }
    
    func append(item: ItemModel) {
        self.items.append(item)
        template.reloadViewModelsItems()
    }
    
    func insert(item: ItemModel, at index: Int) {
        containerData.intert(item: item, at: index)
    }
    
    func replace(item: ItemModel) {
        if let replaceIndex = items.firstIndex(where: { return item.id == $0.id }) {
            items[replaceIndex].cells = item.cells
            template.reloadViewModelsCells()
        } else {
            items.append(item)
            template.reloadViewModelsItems()
        }
    }
    
    func remove(item at: Int) {
        items.remove(at: at)
        getData().set(items: items)
        template.reloadViewModelsItems()
    }
    
    func removeAll() {
        items.removeAll()
        template.reloadViewModelsItems()
    }
    
    func item(id: String?) -> ItemModel {
        return items.first(where: {$0.id == id })!
    }
    
    func item(index: Int) -> ItemModel {
        return items[index]
    }
    
    func item(type: ItemModel.Identifiers) -> ItemModel {
        return item(id: type.rawValue)
    }
    
}
