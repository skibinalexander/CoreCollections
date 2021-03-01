//
//  ItemModel.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

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
