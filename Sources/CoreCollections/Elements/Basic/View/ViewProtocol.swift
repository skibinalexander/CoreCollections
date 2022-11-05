//
//  ViewProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public protocol ViewProtocol: AnyObject {
    
    // MARK: - Static
    
    /// Идентификатор создания UI
    static var identifier: String { get }
    
    /// Идентификатор создания UI
    var identifier: String { get }
    
}

extension ViewProtocol {
    public static var identifier: String { return String(describing: Self.self) }
    public var identifier: String { return String(describing: Self.self) }
}
