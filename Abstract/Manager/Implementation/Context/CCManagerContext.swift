//
//  CCManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCManagerContext: CCManagerContextProtocol {
    
    // MARK: - Static
    static func instance() -> CCManagerContextProtocol {
        return CCManagerContext()
    }
    
    // MARK: - Public Properties
    public var items: [CCItemModel] = []
    
    // MARK: - Private Properties
    internal weak var template: CCTemplateViewModels!
    internal weak var viewDelegate: CCManagerContextViewCallbackProtocol!
}

// MARK: - Setters
extension CCManagerContext {
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
}
