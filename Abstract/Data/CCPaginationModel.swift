//
//  CCPaginationModel.swift
//  Vezu
//
//  Created by Пользователь on 29/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

struct CCPaginationModel<T> {
    var current:    T?
    var limit:      Int
    var hasMore:    Bool?
    
    init(current: T? = nil, limit: Int = 25, hasMore: Bool? = false) {
        self.current = current
        self.limit = limit
        self.hasMore = hasMore
    }
    
}
