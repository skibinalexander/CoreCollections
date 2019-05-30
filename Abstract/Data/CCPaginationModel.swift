//
//  CCPaginationModel.swift
//  Vezu
//
//  Created by Пользователь on 29/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

struct CCPaginationModel {
    var currentItem:    Int?
    var countItems:     Int?
    var itemsOnPage:    Int?
    var hasMore:        Bool?
    
    init(currentItem: Int? = nil, countItems: Int? = nil, itemsOnPage: Int? = 25, hasMore: Bool? = false) {
        self.currentItem = currentItem
        self.countItems = countItems
        self.itemsOnPage = itemsOnPage
        self.hasMore = hasMore
    }
    
}
