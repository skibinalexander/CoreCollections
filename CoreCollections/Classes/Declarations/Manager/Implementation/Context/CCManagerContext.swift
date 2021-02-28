//
//  ManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 SkibinAlexander. All rights reserved.
//

import Foundation

/// Класс реализации контекста управления данными коллекции
class ManagerContext: ManagerContextProtocol {
    
    // MARK: - Static
    
    /// Создание нового уникального контекста для работы с коллекцией
    ///
    /// Создает экземпляер контекста
    static func newContext() -> ManagerContextProtocol {
        ManagerContext()
    }
    
    // MARK: - Public Properties
    
    /// Список items слоя моделей для коллекции
    
    public var items: [ItemModel] = []
    
    // MARK: - Private Properties
    
    /// Шаблон с которым работает контекст данных коллекции
    internal weak var template: TemplateViewModels!
    
    /// UI закрытый протоколом который обновляем контекст по струтуре данных коллекции
    internal weak var viewDelegate: ManagerContextViewCallbackProtocol!
    
}

extension ManagerContext {
    
    /// Короткая проверка наличия items
    func isEmpty() -> Bool {
        return self.items.isEmpty
    }
    
}
