//
//  Item.swift
//

import Combine
import Foundation

public class Item<U, Cell>: NSObject, Identifiable {
    
    public typealias ID = String
    public typealias SectionType = U
    public typealias CellType = Cell
    
    // MARK: - Properties
    
    public var id: String
    
    /// Header item
    public var header: U?
    
    /// Footer item
    public var footer: U?
    
    /// Набор ячеек в item
    public var cells: [Cell] = []
    
    // MARK: - Lifecycle
    
    public init(
        id: String,
        header: U? = nil,
        footer: U? = nil,
        cells: [Cell] = []
    ) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
}
