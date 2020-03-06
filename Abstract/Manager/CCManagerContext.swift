//
//  CCManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCManagerContextViewCallbackProtocol: class {
    func didReloadAllInAllItems()
    func didRefreshAllInAllItems()
    func didRefreshCellsInAllItems()
    func didRefreshSectionAllItems()
    func didReplaceCells()
    func didAppendCells()
    func didInsertCells(paths: [IndexPath])
    func didRemoveCell()
    func didRemoveAllCell()
    func didAppendHeader()
}

extension CCManagerContextViewCallbackProtocol {
    func didReloadAllInAllItems() {}
    func didRefreshAllInAllItems() {}
    func didRefreshCellsInAllItems() {}
    func didRefreshSectionAllItems() {}
    func didReplaceCells() {}
    func didAppendCells() {}
    func didInsertCells(paths: [IndexPath]) {}
    func didRemoveCell() {}
    func didRemoveAllCell() {}
    func didAppendHeader() {}
}

protocol CCManagerContextProtocol: class {
    func set(viewDelegate: CCManagerContextViewCallbackProtocol?)
    func set(template: CCTemplateViewModels?)
    func set(items: [CCItemModel]?)
    func intert(item: CCItemModel, at index: Int)
    
    func isEmpty() -> Bool
    
    func reloadAllInAllItems()
    func refreshAllInAllItems()
    func refreshCellsInAllItems()
    func refreshSectionAllItems()
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol])
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol])
    func insertCells(in item: CCItemModel?, cells:[CCModelCellProtocol], by position: Int)
    func removeCell(in item: CCItemModel?, by position: Int)
    func removeAllCell(in item: CCItemModel?)
    func appendHeader(in item: CCItemModel, header: CCModelSectionProtocol)
}

class CCManagerContext: CCManagerContextProtocol {
    // MARK: - Static
    static func instance() -> CCManagerContextProtocol {
        return CCManagerContext()
    }
    
    // MARK: - Properties
    private weak var template: CCTemplateViewModels!
    private var items: [CCItemModel] = []
    
    private weak var viewDelegate: CCManagerContextViewCallbackProtocol!
    
    // MARK: - Setters
    func set(template: CCTemplateViewModels?) {
        self.template = template
    }
    
    func set(viewDelegate: CCManagerContextViewCallbackProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    func set(items: [CCItemModel]?) {
        self.items = items ?? []
    }
    
    func intert(item: CCItemModel, at index: Int) {
        self.items.insert(item, at: index)
    }
    
    func isEmpty() -> Bool {
        return self.items.isEmpty
    }
    
    // MARK: -
    func reloadAllInAllItems() {
        template.reloadViewModelSections()
        template.reloadViewModelsCells()
        viewDelegate.didReloadAllInAllItems()
    }
    
    func refreshAllInAllItems() {
        items.forEach({$0.header = nil})
        items.forEach({$0.footer = nil})
        template.reloadViewModelSections()
        
        items.forEach({$0.cells = []})
        template.reloadViewModelsCells()
        
        viewDelegate.didRefreshAllInAllItems()
    }
    
    func refreshSectionAllItems() {
        items.forEach({$0.cells = []})
        template.reloadViewModelSections()
        viewDelegate.didRefreshSectionAllItems()
    }
    
    func refreshCellsInAllItems() {
        items.forEach({$0.cells = []})
        template.reloadViewModelsCells()
        viewDelegate.didRefreshCellsInAllItems()
    }
    
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol]) {
        item.cells = cells
        template.reloadViewModelsCells()
        viewDelegate.didReplaceCells()
    }
    
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol]) {
        item.cells.append(contentsOf: cells)
        template.reloadViewModelsCells()
        viewDelegate.didAppendCells()
    }
    
    func insertCells(in item: CCItemModel?, cells: [CCModelCellProtocol], by position: Int) {
        if position >= 0 {
            item?.cells.insert(contentsOf: cells, at: position)
            viewDelegate.didAppendCells()
            viewDelegate.didInsertCells(paths: template.insertCells())
        }
    }
    
    func removeCell(in item: CCItemModel?, by position: Int) {
        item?.cells.remove(at: position)
    }
    
    func removeAllCell(in item: CCItemModel?) {
        item?.cells.removeAll()
    }
    
    func appendHeader(in item: CCItemModel, header: CCModelSectionProtocol) {
        item.header = header
        template.reloadViewModelSections()
        viewDelegate.didAppendHeader()
    }
}
