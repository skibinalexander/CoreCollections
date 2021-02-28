//
//  CCCollectionViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCCollectionViewModelCellProtocol: ModelCellProtocol {
    
}

class CCCollectionViewModelCell: CCCollectionViewModelCellProtocol {
    weak var item:      ItemModel?
    weak var viewModel: ViewModelProtocol?
    var id:             String?
    
    init(id: String? = nil) {
        self.id = id
    }
}
