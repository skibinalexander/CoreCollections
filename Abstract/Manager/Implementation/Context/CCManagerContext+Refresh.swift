//
//  CCManagerContext+Refresh.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - Refreshing
extension CCManagerContext {
    func refreshAllItems() {
        items = []
        template.reloadViewModelsItems()
        viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
    func reloadAllInAllItems(viewCallback type: CCManagerContextViewCallbackType) {
        template.reloadViewModelsItems()
        viewDelegate.didUpdateView(with: type)
    }
    
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
