//
//  Item.swift
//  Vezu
//
//  Created by Ольга on 18/05/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

public class Items<U, T>: NSObject {
    
    typealias SectionType = U
    typealias CellType = T
    
    // MARK: - Properties
    
    /// Идектификатор Item
    public var id: String?
    
    /// Header item
    public var header: U?
    
    /// Footer item
    public var footer: U?
    
    /// Набор ячеек в item
    public var cells: [T?] = []
    
    // MARK: - Lifecycle
    
    public init(
        id: String? = nil,
        header: U? = nil,
        footer: U? = nil,
        cells: [T?] = []
    ) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
}
