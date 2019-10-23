//
//  CCTableViewViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - Base ViewModelCell

class CCTableViewViewModelCell<V: CCTableViewCellProtocol, M: CCTableViewModelCellProtocol>: CCViewModelCell<V, M> {
    
}

// MARK: - Expanded ViewModelCell

protocol CCTableViewViewModelExpandedCellProtocol {
    func changeHeight(with state: CCTableViewViewModelExpandedState)
}

class CCTableViewViewModelExpandedCell<V: CCTableViewCellProtocol, M: CCTableViewModelCell>: CCTableViewViewModelCell<V, M>, CCTableViewViewModelExpandedCellProtocol {
    
    // MARK: - Private
    
    private var expandedHeight: CCViewModelHeight?
    
    // MARK: - Lifecycle
    
    convenience init(nibId: String, nibType: CCViewModelCellViewSourceType, expandedHeight: CCViewModelHeight) {
        self.init(nibType: nibType, height: expandedHeight)
        self.expandedHeight = expandedHeight
    }
    
    // MARK: - Public
    
    public func changeHeight(with state: CCTableViewViewModelExpandedState) {
        self.height = (state == .expanded) ? self.expandedHeight ?? .value(.zero) : .value(.zero)
    }
    
}
