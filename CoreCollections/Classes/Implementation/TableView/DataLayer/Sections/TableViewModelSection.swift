//
//  CCTableViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

open class TableViewModelSection: ModelSectionProtocol {
    
    // MARK: - ModelSectionProtocol
    
    public var id: String?
    
    // MARK: - Injection Properties
    
    public weak var item: ItemModel?
    public weak var viewModel: ViewModelProtocol?
    
    // MARK: - Lifecycle
    
    init(id: String? = nil) {
        self.id = id
    }
    
}
