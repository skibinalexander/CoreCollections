//
//  CCManagerContext+CCManagerContextSettersProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 05.07.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Foundation

// MARK: - CCManagerContextSettersProtocol

extension CCManagerContext {
    
    /// Шаблон
    func set(template: CCTemplateViewModels) {
        self.template = template
    }
    
    /// UI делегат
    func set(viewDelegate: CCManagerContextViewCallbackProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    /// Список items
    func set(items: [CCItemModel]) {
        self.items = items
    }
}
