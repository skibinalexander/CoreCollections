//
//  Item.swift
//

import Combine
import Foundation

public class Item<U, T>: NSObject, Identifiable, ObservableObject {
    
    public typealias ID = String
    public typealias SectionType = U
    public typealias CellType = T
    
    // MARK: - Properties
    
    public var id: String
    
    /// Header item
    @Published public var header: U?
    
    /// Footer item
    @Published public var footer: U?
    
    /// Набор ячеек в item
    @Published public var cells: [T] = []
    
    // MARK: - Lifecycle
    
    public init(
        id: String,
        header: U? = nil,
        footer: U? = nil,
        cells: [T] = []
    ) {
        self.id = id
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
    // MARK: -
    
    public var itemDidChange: AnyPublisher<Void, Never> {
        self.objectWillChange
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
