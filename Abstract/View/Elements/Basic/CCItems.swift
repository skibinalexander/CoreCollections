//
//  CCItem.swift
//  Vezu
//
//  Created by Ольга on 18/05/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCItems<U, T>: NSObject {
    
    typealias SectionType = U
    typealias CellType = T
    
    // MARK: - Properties
    
    var id:         String?
    
    var header:     U?
    var footer:     U?
    var cells:      [T?] = []
    
    // MARK: - Lifecycle
    
    init(id: String? = nil, header: U? = nil, footer: U? = nil, cells: [T?] = []) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
}

// MARK: - CCItemModels

class CCItemModel: CCItems<CCModelSectionProtocol, CCModelCellProtocol> {
    
    public enum Identifiers: String {
        case single
        case top
        case middle
        case bottom
        case list
        case content
    }
    
    static func single() -> CCItemModel {
        return CCItemModel(id: Identifiers.single.rawValue)
    }
    
    static func top(header: CCModelSectionProtocol? = nil) -> CCItemModel {
        return CCItemModel(id: Identifiers.top.rawValue, header: header)
    }
    
    static func middle() -> CCItemModel {
        return CCItemModel(id: Identifiers.middle.rawValue)
    }
    
    static func bottom(header: CCModelSectionProtocol? = nil) -> CCItemModel {
        return CCItemModel(id: Identifiers.bottom.rawValue, header: header)
    }
    
    static func list(header: CCModelSectionProtocol? = nil) -> CCItemModel {
        return CCItemModel(id: Identifiers.list.rawValue, header: header)
    }
    
    static func content(header: CCModelSectionProtocol? = nil) -> CCItemModel {
        return CCItemModel(id: Identifiers.content.rawValue, header: header)
    }
    
}

// MARK: - CCItemViewModelsProtocol

class CCItemViewModel: CCItems<CCViewModelProtocol, CCViewModelProtocol> {
    
}
