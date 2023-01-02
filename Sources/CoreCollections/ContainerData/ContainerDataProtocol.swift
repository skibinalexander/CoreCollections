//
//  ContainerDataProtocol.swift
//  CoreCollections
//
//  Created by skibinalexander on 30.12.2022.
//

import Foundation

public protocol ContainerDataProtocol: AnyObject {
    
    /// Набор Item в текущем контексте коллекции
    var items: [ItemViewModel] { get set }
    
}
