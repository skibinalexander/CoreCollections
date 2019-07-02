//
//  CCCollectionViewModelSection.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCCollectionViewModelSection: CCModelSectionProtocol {
    
    //  MARK: CCModelSectionProtocol
    
    weak var item: CCItemModel?
    weak var viewModel: CCViewModelProtocol?
    var modelId: String?
    
    init(modelId: String? = nil) {
        self.modelId = modelId
    }
    
}
