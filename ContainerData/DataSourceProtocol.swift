//
//  DataSourceProtocol.swift
//  CoreCollections
//
//  Created by skibinalexander on 31.12.2022.
//

import Foundation

public protocol DataSourceProtocol {
    
    /// Chain data source
    var chain: DataSourceProtocol? { get set }
    
    /// Контейнер данных
    var containerData: ContainerDataProtocol { get set }
    
    // MARK: - Init
    
    init(_ chain: DataSourceProtocol?, containerData: ContainerDataProtocol)
    
}
