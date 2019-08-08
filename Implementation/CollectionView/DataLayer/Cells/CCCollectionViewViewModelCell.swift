//
//  File.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - Base ViewModelCell

class CCCollectionViewViewModelCell<V: CCCollectionViewCell, M: CCCollectionViewModelCellProtocol>: CCViewModelCell<V, M> {
    
}

// MARK: - Expanded ViewModelCell

protocol CCCollectionViewViewModelExpandedCellProtocol {
    func changeHeight(with state: CCCollectionViewViewModelExpandedState)
}

class CCCollectionViewViewModelExpandedCell<V: CCCollectionViewCell, M: CCCollectionViewModelCell>: CCCollectionViewViewModelCell<V, M>, CCCollectionViewViewModelExpandedCellProtocol {
    
    // MARK: - Private
    
    private var expandedHeight: CCViewModelHeight?
    
    // MARK: - Lifecycle
    
    convenience init(output: CCViewModelCellOutputProtocol? = nil, nibId: String, nibType: CCViewModelCellViewSourceType, expandedHeight: CCViewModelHeight) {
        self.init(output: output, nibId: nibId, nibType: nibType, height: expandedHeight)
        
        self.expandedHeight = expandedHeight
    }
    
    // MARK: - Public
    
    public func changeHeight(with state: CCCollectionViewViewModelExpandedState) {
        self.height = (state == .expanded) ? self.expandedHeight ?? .value(.zero) : .value(.zero)
    }
    
}
