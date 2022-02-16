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
    
    func operationAllItems(type: ManagerContenxtOperationType, viewCallback: ManagerContextViewCallbackType) {
        switch type {
        case .refresh:
            refreshAllInAllItems(with: viewCallback)
        case .reload:
            reloadAllInAllItems(with: viewCallback)
        case .remove:
            removeAllItems(with: viewCallback)
        default:
            break
        }
    }
    
    // MARK: - Private Implementation
    
    /// Выполнить облновление слоя вью моделей в соотвествии со слоем моделей коллекции
    ///
    /// - Обновляет слой вью моделей
    /// - Сообщает вью слою коллекции о необходимости обновления по типу
    private func reloadAllInAllItems(with viewCallback: ManagerContextViewCallbackType) {
        mapper.reloadViewModelsItems()
        viewDelegate.didUpdateView(with: viewCallback)
    }
    
    /// Выполнить облновление слоя вью моделей в соотвествии со слоем моделей коллекции
    ///
    /// - Обновляет слой вью моделей
    /// - Сообщает вью слою коллекции о необходимости обновления по типу
    private func refreshAllInAllItems(with viewCallback: ManagerContextViewCallbackType) {
        items.forEach({$0.header = nil})
        items.forEach({$0.footer = nil})
        mapper.reloadViewModelSections()
        
        items.forEach({$0.cells = []})
        mapper.reloadViewModelsCells()
        
        viewDelegate.didUpdateView(with: viewCallback)
    }
    
    /// Выполнить refresh для всех items
    ///
    /// - Очищает все item в колекции слоя моделей
    /// - Обновляет слой вью моделей
    /// - Сообщает вью слою коллекции о необходимости обновления
    private func removeAllItems(with viewCallback: ManagerContextViewCallbackType) {
        items = []
        mapper.reloadViewModelsItems()
        viewDelegate.didUpdateView(with: viewCallback)
    }
    
    // ---
    
    func refreshSectionsInAllItems() {
        items.forEach({$0.header = nil})
        mapper.reloadViewModelSections()
        viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
    func refreshCellsInAllItems() {
       items.forEach({$0.cells = []})
       mapper.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
}
