//
//  CCModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCModelCellProtocol: CCModelProtocol {
    
}

/// Базовый класс для ячеек в CoreCollection
public class CCModelCell: CCModelCellProtocol {
    
    var id: String?
    
    var item: CCItemModel?
    
    var viewModel: CCViewModelProtocol?
    
    // MARK: - Lifecycle
    
    init(id: String? = nil) {
        self.id = id
    }
    
}
