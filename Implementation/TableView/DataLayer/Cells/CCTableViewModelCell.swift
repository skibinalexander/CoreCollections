//
//  CCTableViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewModelCell: CCModelCellProtocol {
    weak var item:      CCItemModel?
    weak var viewModel: CCViewModelProtocol?
    var modelId:        String?
    
    init(modelId: String? = nil) {
        self.modelId = modelId
    }
}
