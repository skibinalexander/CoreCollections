//
//  CCItem.swift
//  Vezu
//
//  Created by Ольга on 18/05/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCItems<U, T> {
    
    typealias SectionType = U
    typealias CellType = T
    
    //  MARK: Properties
    
    var id:         String?
    
    var header:     U?
    var footer:     U?
    var cells:      [T?]
    
    //  MARK: Lifecycle
    
    init(id: String? = nil, header: U? = nil, footer: U? = nil, cells: [T?] = []) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
}

//  MARK: CCItemModels

class CCItemModel: CCItems<CCModelSectionProtocol, CCModelCellProtocol> {
    
    enum identifiers: String {
        case signle = "single"
        case top = "top"
        case middle = "middle"
        case bottom = "bottom"
        case list = "list"
        case content = "content"
    }
    
    static func single() -> CCItemModel {
        return CCItemModel(id: identifiers.signle.rawValue)
    }
    
    static func top() -> CCItemModel {
        return CCItemModel(id: identifiers.top.rawValue)
    }
    
    static func middle() -> CCItemModel {
        return CCItemModel(id: identifiers.middle.rawValue)
    }
    
    static func bottom() -> CCItemModel {
        return CCItemModel(id: identifiers.bottom.rawValue)
    }
    
    static func list() -> CCItemModel {
        return CCItemModel(id: identifiers.list.rawValue)
    }
    
    static func content() -> CCItemModel {
        return CCItemModel(id: identifiers.content.rawValue)
    }
    
}

//  MARK: CCItemViewModelsProtocol

class CCItemViewModel: CCItems<CCViewModelProtocol, CCViewModelProtocol> {
    
}


