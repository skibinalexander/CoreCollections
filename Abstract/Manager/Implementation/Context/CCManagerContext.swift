//
//  CCManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 SkibinAlexander. All rights reserved.
//

import Foundation

/// Класс реализации контекста управления данными коллекции
class CCManagerContext: CCManagerContextProtocol {
    
    // MARK: - Static
    
    /// Создание нового уникального контекста для работы с коллекцией
    ///
    /// Создает экземпляер контекста
    static func newContext() -> CCManagerContextProtocol {
        CCManagerContext()
    }
    
    // MARK: - Public Properties
    
    /// Список items слоя моделей для коллекции
    
    public var items: [CCItemModel] = []
    
    // MARK: - Private Properties
    
    /// Шаблон с которым работает контекст данных коллекции
    internal weak var template: CCTemplateViewModels!
    
    /// UI закрытый протоколом который обновляем контекст по струтуре данных коллекции
    internal weak var viewDelegate: CCManagerContextViewCallbackProtocol!
    
}

extension CCManagerContext {
    
    /// Короткая проверка наличия items
    func isEmpty() -> Bool {
        return self.items.isEmpty
    }
    
}
