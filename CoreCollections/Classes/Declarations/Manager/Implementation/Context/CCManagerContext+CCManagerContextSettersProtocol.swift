//
//  ManagerContext+ManagerContextSettersProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 05.07.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Foundation

// MARK: - ManagerContextSettersProtocol

extension ManagerContext {
    
    /// Шаблон
    func set(template: TemplateViewModels) {
        self.template = template
    }
    
    /// UI делегат
    func set(viewDelegate: ManagerContextViewCallbackProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    /// Список items
    func set(items: [ItemModel]) {
        self.items = items
    }
}
