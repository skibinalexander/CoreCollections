//
//  DataSourceProtocol.swift
//  CoreCollections
//
//  Created by skibinalexander on 31.12.2022.
//

import UIKit

public protocol DataSourceProtocol {
    
    associatedtype CollectionView: UIView
    
    /// Контейнер данных
    var containerData: ContainerDataProtocol { get set }
    
    // MARK: - Init
    
    init(
        collectionView: CollectionView,
        containerData: ContainerDataProtocol
    )
    
}
