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

class CCTableViewModelCell: CCTableViewModelCellProtocol {
    var id:             String?
    weak var item:      CCItemModel?
    weak var viewModel: CCViewModelProtocol?
    
    init(id: String? = nil) {
        self.id = id
    }
}
