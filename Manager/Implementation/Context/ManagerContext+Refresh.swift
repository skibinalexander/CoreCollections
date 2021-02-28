//
//  ManagerContext+Refresh.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - Refreshing

public extension ManagerContext {
    
    /// Выполнить refresh для всех items
    ///
    /// - Очищает все item в колекции слоя моделей
    /// - Обновляет слой вью моделей
    /// - Сообщает вью слою коллекции о необходимости обновления
    func refreshAllItems() {
        items = []
        template.reloadViewModelsItems()
        viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
    /// Выполнить облновление слоя вью моделей в соотвествии со слоем моделей коллекции
    ///
    /// - Обновляет слой вью моделей
    /// - Сообщает вью слою коллекции о необходимости обновления по типу
    func reloadAllInAllItems(viewCallback type: ManagerContextViewCallbackType) {
        template.reloadViewModelsItems()
        viewDelegate.didUpdateView(with: type)
    }
    
    /// Выполнить облновление слоя вью моделей в соотвествии со слоем моделей коллекции
    ///
    /// - Обновляет слой вью моделей
    /// - Сообщает вью слою коллекции о необходимости обновления по типу
    func refreshAllInAllItems() {
        items.forEach({$0.header = nil})
        items.forEach({$0.footer = nil})
        template.reloadViewModelSections()
        
        items.forEach({$0.cells = []})
        template.reloadViewModelsCells()
        
        viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
    func refreshSectionsInAllItems() {
        items.forEach({$0.header = nil})
        template.reloadViewModelSections()
        viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
    func refreshCellsInAllItems() {
       items.forEach({$0.cells = []})
       template.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
}
