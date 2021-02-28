//
//  ManagerContextSettersProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public protocol ManagerContextSettersProtocol {
    func set(viewDelegate: ManagerContextViewCallbackProtocol)
    func set(template: TemplateViewModels)
    func set(items: [ItemModel])
}
