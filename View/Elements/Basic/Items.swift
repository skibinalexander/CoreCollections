//
//  Item.swift
//  Vezu
//
//  Created by Ольга on 18/05/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - Abstract
public class Items<U, T>: NSObject {
    
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

// MARK: - ItemModels

public class ItemModel: Items<ModelSectionProtocol, ModelCellProtocol> {
    
    public enum Identifiers: String {
        case single
        case top
        case middle
        case bottom
        case list
        case content
    }
    
    public static func single() -> ItemModel {
        return ItemModel(id: Identifiers.single.rawValue)
    }
    
    public static func top(header: ModelSectionProtocol? = nil) -> ItemModel {
        return ItemModel(id: Identifiers.top.rawValue, header: header)
    }
    
    public static func middle() -> ItemModel {
        return ItemModel(id: Identifiers.middle.rawValue)
    }
    
    public static func bottom(header: ModelSectionProtocol? = nil, cells: [ModelCellProtocol] = []) -> ItemModel {
        return ItemModel(id: Identifiers.bottom.rawValue, header: header, cells: cells)
    }
    
    public static func list(header: ModelSectionProtocol? = nil) -> ItemModel {
        return ItemModel(id: Identifiers.list.rawValue, header: header)
    }
    
    public static func content(header: ModelSectionProtocol? = nil, cells: [ModelCellProtocol] = []) -> ItemModel {
        return ItemModel(id: Identifiers.content.rawValue, header: header, cells: cells)
    }
    
}

// MARK: - ItemViewModelsProtocol

/// Базовая реализация ViewModel для Item коллекции
public class ItemViewModel: Items<ViewModelSectionProtocol, ViewModelCellProtocol> {}
