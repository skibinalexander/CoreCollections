//
//  CCTableViewViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: Base ViewModelCell

class CCTableViewViewModelCell: CCViewModelCell {
    
}

//  MARK: Expanded ViewModelCell

class CCTableViewViewModelExpandedCell: CCTableViewViewModelCell {
    
    //  MARK: Private
    
    private var expandedHeight: Float?
    
    //  MARK: Lifecycle
    
    convenience init(output: CCViewModelCellOutputProtocol?, nibId: String, nibType: CCViewModelCellViewSourceType, expandedHeight: Float) {
        self.init(output: output, nibId: nibId, nibType: nibType, height: expandedHeight)
        
        self.expandedHeight = expandedHeight
    }
    
    //  MARK: Public
    
    public func changeHeight(with state: CCTableViewViewModelExpandedState) {
        self.height = (state == .expanded) ? (self.expandedHeight ?? .zero) : .zero
    }
    
}
