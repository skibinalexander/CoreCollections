//
//  CCTableViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

protocol CCTableViewModelSectionProtocol: CCModelSectionProtocol {
    
}

class CCTableViewModelSection: CCTableViewModelSectionProtocol {
    // MARK: - CCModelSectionProtocol
    var id: String?
    weak var item: CCItemModel?
    weak var viewModel: CCViewModelProtocol?
    
    init(id: String? = nil) {
        self.id = id
    }
    
}
