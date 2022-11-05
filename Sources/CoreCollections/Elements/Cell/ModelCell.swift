//
//  ModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовый интерфейс реализации модели ячейки коллекции
public protocol ModelCellProtocol: ModelProtocol {}

/// Базовый класс для ячеек в CoreCollection
open class ModelCell: ModelCellProtocol {
    
    // MARK: - Stored Properties
    
    /// Идентификатор ячейки
    public var id: String?
    
    // MARK: - Injection Properties
    
    /// Item коллекции
    public var item: ItemModel?
    
    /// ViewModel ячейки
    public var viewModel: ViewModelProtocol?
    
    // MARK: - Lifecycle
    
    public init(id: String? = nil) {
        self.id = id
    }
    
}
