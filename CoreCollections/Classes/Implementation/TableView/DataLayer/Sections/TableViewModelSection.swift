//
//  CCTableViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

class TableViewModelSection: ModelSectionProtocol {
    
    // MARK: - ModelSectionProtocol
    
    var id: String?
    
    // MARK: - Injection Properties
    
    weak var item: ItemModel?
    weak var viewModel: ViewModelProtocol?
    
    // MARK: - Lifecycle
    
    init(id: String? = nil) {
        self.id = id
    }
    
}
