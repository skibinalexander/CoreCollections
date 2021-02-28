//
//  ManagerContext+ManagerContextSettersProtocolss.swift
//  Parcel
//
//  Created by Skibin Alexander on 05.07.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Foundation

// MARK: - ManagerContextItemsProtocol

extension ManagerContext {
    
    // - Добавить item в конец списка
    func append(item: ItemModel) {
        self.items.append(item)
    }
    
    // - Добавить item по индексу
    func intert(item: ItemModel, at index: Int) {
        self.items.insert(item, at: index)
    }
    
    // - Удалить item по идексу
    func remove(item: ItemModel, at index: Int) {
        self.items.remove(at: index)
    }
    
}
