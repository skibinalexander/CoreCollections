//
//  CCPaginationModel.swift
//  Vezu
//
//  Created by Пользователь on 29/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

/// Базовая структура данных модели для пагинации коллекционного списка
public struct PaginationModel<T> {
    
    /// Текущий элемент
    var current: T?
    
    /// Лимит вывода списка пагинации
    var limit: Int
    
    /// Флаг подгрузки новых данных в таблице
    var hasMore: Bool?
    
    // MARK: - Initialization
    
    init(current: T? = nil, limit: Int = 25, hasMore: Bool? = true) {
        self.current = current
        self.limit = limit
        self.hasMore = hasMore
    }
    
}