//
//  CCCollectionViewModelSection.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCCollectionViewModelSection: ModelSectionProtocol {
    
    // MARK: - ModelSectionProtocol
    
    weak var item: ItemModel?
    weak var viewModel: ViewModelProtocol?
    var id: String?
    
    init(id: String? = nil) {
        self.id = id
    }
    
}
