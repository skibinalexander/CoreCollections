//
//  ManagerContext.swift
//  Vezu
//
//  Created by Ольга on 26/10/2019.
//  Copyright © 2019 SkibinAlexander. All rights reserved.
//

import Foundation

/// Класс реализации контекста управления данными коллекции
public class ManagerContext: ManagerContextProtocol {
    
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
    
    // MARK: - Setters
    
    /// Шаблон
    public func set(template: TemplateViewModels) {
        self.template = template
    }
    
    /// UI делегат
    public func set(viewDelegate: ManagerContextViewCallbackProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    /// Список items
    public func set(items: [ItemModel]) {
        self.items = items
    }
    
    // MARK: - Items managment
    
    /// Добавить item в коллекцию
    /// - Parameter item: Item коллекции
    public func append(item: ItemModel) {
        self.items.append(item)
    }
    
    /// Вставить item по индексу
    /// - Parameters:
    ///   - item: Item коллекции
    ///   - index: Индекс вставки
    public func intert(item: ItemModel, at index: Int) {
        self.items.insert(item, at: index)
    }
    
    /// Удалить item по индексу
    /// - Parameters:
    ///   - item: item коллекции
    ///   - index: Индекс удаления
    public func remove(item: ItemModel, at index: Int) {
        self.items.remove(at: index)
    }
    
    /// Короткая проверка наличия items
    public func isEmpty() -> Bool {
        return self.items.isEmpty
    }
    
}
