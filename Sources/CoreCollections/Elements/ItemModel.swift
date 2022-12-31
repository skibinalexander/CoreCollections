//
//  ItemModel.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public class ItemViewModel: Item<ViewModelProtocol, ViewModelProtocol> {
    
    public enum Identifiers: String, Identifiable {
        
        public typealias ID = Item<ViewModelProtocol, ViewModelProtocol>.ID
        
        public var id: Item<ViewModelProtocol, ViewModelProtocol>.ID {
            return .init(NSString(string: self.rawValue))
        }
        
        case single
        case top
        case middle
        case bottom
        case list
        case content
    }
    
    public static func single() -> ItemViewModel {
        return ItemViewModel(id: Identifiers.single.id)
    }
    
    public static func top<H: ViewModelProtocol>(header: H? = nil) -> ItemViewModel {
        return ItemViewModel(id: Identifiers.top.id, header: header)
    }
    
    public static func middle() -> ItemViewModel {
        return ItemViewModel(id: Identifiers.middle.id)
    }
    
    public static func bottom<H: ViewModelProtocol, C: ViewModelProtocol>(header: H? = nil, cells: [C] = []) -> ItemViewModel {
        return ItemViewModel(id: Identifiers.bottom.id, header: header, cells: cells)
    }
    
    public static func list<H: ViewModelProtocol>(header: H? = nil) -> ItemViewModel {
        return ItemViewModel(id: Identifiers.list.id, header: header)
    }
    
    public static func content<H: ViewModelProtocol, C: ViewModelProtocol>(header: H? = nil, cells: [C] = []) -> ItemViewModel {
        return ItemViewModel(id: Identifiers.content.id, header: header, cells: cells)
    }
    
}
