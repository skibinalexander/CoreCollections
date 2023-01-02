//
//  Item.swift
//

import Combine
import Foundation

public class Item<U, T>: NSObject, Identifiable, ObservableObject {
    
    typealias SectionType = U
    typealias CellType = T
    
    // MARK: - Properties
    
    public var id: ObjectIdentifier
    
    /// Header item
    @Published public var header: U?
    
    /// Footer item
    @Published public var footer: U?
    
    /// Набор ячеек в item
    @Published public var cells: [T] = []
    
    // MARK: - Lifecycle
    
    public init(
        id: ObjectIdentifier,
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
