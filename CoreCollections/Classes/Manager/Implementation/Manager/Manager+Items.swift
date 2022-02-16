//
//  Manager+Items.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public extension Manager {
    
    func item(id: String?) -> ItemModel {
        return containerData.items.first(where: {$0.id == id })!
    }
    
    func item(index: Int) -> ItemModel {
        return containerData.items[index]
    }
    
    func item(type: ItemModel.Identifiers) -> ItemModel {
        return item(id: type.rawValue)
    }
    
}
