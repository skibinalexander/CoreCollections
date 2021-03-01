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
