//
//  CCManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

enum CCManagerContextViewCallbackType {
    case withoutChangeView
    case reloadCollection
    case reloadInSection(Int)
    case insertIntoCollection
    case removeFromCollection
}

protocol CCManagerContextViewCallbackProtocol: class {
    func didUpdateView(with type: CCManagerContextViewCallbackType)
    func didUpdateView(with type: CCManagerContextViewCallbackType, for paths: [IndexPath])
}

protocol CCManagerContextProtocol: class {
    var items: [CCItemModel] { get set }
    
    func set(viewDelegate: CCManagerContextViewCallbackProtocol?)
    func set(template: CCTemplateViewModels?)
    func set(items: [CCItemModel]?)
    func intert(item: CCItemModel, at index: Int)
    
    func isEmpty() -> Bool
    
    func refreshAllItems()
    func reloadAllInAllItems(viewCallback type: CCManagerContextViewCallbackType)
    func refreshAllInAllItems()
    func refreshCellsInAllItems()
    func refreshSectionsInAllItems()
    
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType)
    func replaceCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType)
    
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol])
    func insertCells(in item: CCItemModel, cells:[CCModelCellProtocol], by position: Int)
    
    func removeCells(in item: CCItemModel, by position: Int)
    func removeCells(in typeId: CCItemModel.Identifiers, by position: Int)
    
    func removeAllCells(in item: CCItemModel)
    func removeAllCells(in typeId: CCItemModel.Identifiers)
}

class CCManagerContext: CCManagerContextProtocol {
    
    // MARK: - Static
    static func instance() -> CCManagerContextProtocol {
        return CCManagerContext()
    }
    
    // MARK: - Public Properties
    public var items: [CCItemModel] = []
    
    // MARK: - Private Properties
    private weak var template: CCTemplateViewModels!
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
}

// MARK: - Cells Context
extension CCManagerContext {
    func refreshCellsInAllItems() {
       items.forEach({$0.cells = []})
       template.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }
    
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType) {
        item.cells = cells
        template.reloadViewModelsCells()
        viewDelegate.didUpdateView(with: type)
    }
    
    func replaceCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            replaceCells(in: item, cells: cells, viewCallback: type)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }

    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol]) {
       item.cells.append(contentsOf: cells)
       template.reloadViewModelsCells()
       viewDelegate.didUpdateView(with: .reloadCollection)
    }

    func insertCells(in item: CCItemModel, cells: [CCModelCellProtocol], by position: Int) {
       if position >= 0 {
           item.cells.insert(contentsOf: cells, at: position)
           viewDelegate.didUpdateView(with: .insertIntoCollection, for: template.insertCells())
       } else {
           assertionFailure("CCManagerContext: Wrong index position")
       }
    }

    func removeCells(in item: CCItemModel, by position: Int) {
       item.cells.remove(at: position)
       viewDelegate.didUpdateView(with: .removeFromCollection, for: template.removeCells())
    }
    
    func removeCells(in typeId: CCItemModel.Identifiers, by position: Int) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            removeCells(in: item, by: position)
        } else {
            assertionFailure("CCManagerContext: undefined id -> \(typeId.rawValue) of item")
        }
    }
    
    func removeAllCells(in item: CCItemModel) {
        guard item.cells.count > 0 else { return }
        removeCells(in: item, by: 0)
    }
    
    func removeAllCells(in typeId: CCItemModel.Identifiers) {
        if let item = items.first(where: { $0.id == typeId.rawValue }) {
            guard item.cells.count > 0 else { return }
            removeCells(in: item, by: 0)
        }
    }
}
