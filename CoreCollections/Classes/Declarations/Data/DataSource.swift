//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

// MARK: - DataSource

/// Базовый интерфейс для реализации источника данных коллекции
protocol DataSourceProtocol: class {
    /// Свойство редактирования порядка ячеек в коллекции
    var canMoveAtRow: Bool { get set }
}

/// Базовая реализация интерфейса DataSourceProtocol
public class DataSource: NSObject, DataSourceProtocol {
    
    // MARK: - Public Properties
    
    var canMoveAtRow: Bool = false
    
    // MARK: - Private Properties7
    
    internal weak var template: TemplateViewModelsProtocol?
    
    // MARK: - Lifecycle
    
    init(template: TemplateViewModelsProtocol) {
        super.init()
        self.template = template
    }
    
}
