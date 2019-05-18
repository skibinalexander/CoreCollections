//
//  CCTableViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCTableViewModelSection: CCModelSectionProtocol {
    
    //  MARK: CCModelSectionProtocol
    
    weak var viewModel: CCViewModelProtocol?
    var modelId: String?
    var cells: [CCModelCellProtocol]
    
    init(modelId: String? = nil, cells: [CCModelCellProtocol] = []) {
        self.modelId = modelId
        self.cells = cells
    }
    
}
