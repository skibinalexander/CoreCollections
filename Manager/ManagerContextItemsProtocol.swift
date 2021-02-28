//
//  ManagerContextItemsProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public protocol ManagerContextItemsProtocol {
    func append(item: ItemModel)
    func intert(item: ItemModel, at index: Int)
    func remove(item: ItemModel, at index: Int)
}
