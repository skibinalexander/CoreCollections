//
//  CCTableViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewModelCellProtocol: CCModelCellProtocol {
    
}

/// Базовый класс для моделей для ячеек
class CCTableViewModelCell: CCTableViewModelCellProtocol {
    
    var id: String?
    
    var item: CCItemModel?
    
    var viewModel: CCViewModelProtocol?
    
    // MARK: - Lifecycle
    
    init(id: String? = nil) {
        self.id = id
    }
    
}
