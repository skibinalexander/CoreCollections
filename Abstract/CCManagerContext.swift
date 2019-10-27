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
    
    func refreshCellsInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void)
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback: (CCContainerViewInputProtocol) -> Void)
    func insertCells(in item: CCItemModel?, by position: Int, viewCallback:(CCContainerViewInputProtocol, IndexPath) -> Void)
}

class CCManagerContext: CCManagerContextProtocol {
    // MARK: - Static
    static func instance() -> CCManagerContextProtocol {
        return CCManagerContext()
    }
    
    // MARK: - Properties
    private weak var template: CCTemplateViewModels!
    private weak var containerView: CCContainerViewInputProtocol!
    private var items: [CCItemModel] = []
    
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
    func refreshAllInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        
    }
    
    func refreshHeadersInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        
    }
    
    func refreshFooterInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        
    }
    
    func refreshCellsInAllItems(viewCallback: (CCContainerViewInputProtocol) -> Void) {
        items.forEach({$0.cells = []})
        template.reloadViewModelsCells()
        viewCallback(self.containerView)
    }
    
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback: (CCContainerViewInputProtocol) -> Void) {
        item.cells = cells
        template.reloadViewModelsCells()
        viewCallback(containerView)
    }
    
    func insertCells(in item: CCItemModel?, by position: Int, viewCallback: (CCContainerViewInputProtocol, IndexPath) -> Void) {
        
    }
}
