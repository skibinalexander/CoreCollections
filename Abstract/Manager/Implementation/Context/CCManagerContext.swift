//
//  CCManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCManagerContext: CCManagerContextProtocol {
    
    // MARK: - Static
    
    /// Создание нового уникального контекста для работы с коллекцией
    ///
    /// Создает экземпляер контекста
    static func instance() -> CCManagerContextProtocol {
        return CCManagerContext()
    }
    
    // MARK: - Public Properties
    
    /// Список items для коллекции
    public var items: [CCItemModel] = []
    
    // MARK: - Private Properties
    
    /// Шаблон с которым работает контекст
    internal weak var template: CCTemplateViewModels!
    
    /// UI закрытый протоколом который обновляем контекст
    internal weak var viewDelegate: CCManagerContextViewCallbackProtocol!
    
}

extension CCManagerContext {
    
    /// Короткая проверка наличия items
    func isEmpty() -> Bool {
        return self.items.isEmpty
    }
    
}
