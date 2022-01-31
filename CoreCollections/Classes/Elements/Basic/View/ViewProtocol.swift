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
    static var typeOf: String { get }
    
    // MARK: - Public Properties
    
    /// ViewModel ячейки или секции
    var viewModel: ViewModelProtocol? { get set }
    
}

extension ViewProtocol {
    public static var typeOf: String { return String(describing: Self.self) }
}
