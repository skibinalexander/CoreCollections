//
//  CCTableViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewModelCell: CCModelCellProtocol {
    var viewModel:  CCViewModel?
    var sectionId:  String
    var modelId:    String?
    
    init(sectionId: String, modelId: String? = nil) {
        self.sectionId = sectionId
        self.modelId = modelId
    }
}
