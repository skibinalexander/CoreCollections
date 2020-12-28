//
//  CCCollectionViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCCollectionViewModelCellProtocol: CCModelCellProtocol {
    
}

class CCCollectionViewModelCell: CCCollectionViewModelCellProtocol {
    weak var item:      CCItemModel?
    weak var viewModel: CCViewModelProtocol?
    var id:             String?
    
    init(id: String? = nil) {
        self.id = id
    }
}
