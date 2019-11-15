//
//  CCManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCManagerContextProtocol: class {
    func set(template: CCTemplateViewModels?)
    func set(containerView: CCContainerViewInputProtocol?)
    func set(items: [CCItemModel]?)
    
    func reloadAllInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void)
    func refreshAllInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void)
    func refreshCellsInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void)
    func refreshSectionAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void)
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback: (CCContainerViewInputProtocol) -> Void)
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback: (CCContainerViewInputProtocol) -> Void)
    func insertCells(in item: CCItemModel?, cells:[CCModelCellProtocol], by position: Int, viewCallback:(CCContainerViewInputProtocol, [IndexPath]) -> Void)
    func removeCell(in item: CCItemModel?, by position: Int, viewCallback:(CCContainerViewInputProtocol, [IndexPath]) -> Void)
    func appendHeader(in item: CCItemModel, header: CCModelSectionProtocol, viewCallback: (CCContainerViewInputProtocol) -> Void)
}

class CCManagerContext: CCManagerContextProtocol {
    // MARK: - Static
    static func instance() -> CCManagerContextProtocol {
        return CCManagerContext()
    }
    
    // MARK: - Properties
    private weak var template: CCTemplateViewModels!
    private var items: [CCItemModel] = []
    
    private weak var containerView: CCContainerViewInputProtocol!
    
    // MARK: - Setters
    func set(template: CCTemplateViewModels?) {
        self.template = template
    }
    
    func set(containerView: CCContainerViewInputProtocol?) {
        self.containerView = containerView
    }
    
    func set(items: [CCItemModel]?) {
        self.items = items ?? []
    }
    
    // MARK: -
    func reloadAllInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        template.reloadViewModelSections()
        template.reloadViewModelsCells()
        viewCallback(self.containerView)
    }
    
    func refreshAllInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        items.forEach({$0.header = nil})
        items.forEach({$0.footer = nil})
        template.reloadViewModelSections()
        
        items.forEach({$0.cells = []})
        template.reloadViewModelsCells()
        
        viewCallback(self.containerView)
    }
    
    func refreshSectionAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        items.forEach({$0.cells = []})
        template.reloadViewModelSections()
        viewCallback(self.containerView)
    }
    
    func refreshCellsInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        items.forEach({$0.cells = []})
        template.reloadViewModelsCells()
        viewCallback(self.containerView)
    }
    
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback: (CCContainerViewInputProtocol) -> Void) {
        item.cells = cells
        template.reloadViewModelsCells()
        viewCallback(containerView)
    }
    
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback: (CCContainerViewInputProtocol) -> Void) {
        item.cells.append(contentsOf: cells)
        template.reloadViewModelsCells()
        viewCallback(containerView)
    }
    
    func insertCells(in item: CCItemModel?, cells: [CCModelCellProtocol], by position: Int, viewCallback: (CCContainerViewInputProtocol, [IndexPath]) -> Void) {
        if position >= 0 {
            item?.cells.insert(contentsOf: cells, at: position)
            viewCallback(containerView, template.insertCells())
        }
    }
    
    func removeCell(in item: CCItemModel?, by position: Int, viewCallback: (CCContainerViewInputProtocol, [IndexPath]) -> Void) {
        item?.cells.remove(at: position)
        viewCallback(containerView, template.removeCells())
        
    }
    
    func appendHeader(in item: CCItemModel, header: CCModelSectionProtocol, viewCallback: (CCContainerViewInputProtocol) -> Void) {
        item.header = header
        template.reloadViewModelSections()
        viewCallback(containerView)
    }
}
