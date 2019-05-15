//
//  CCTableViewViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

//  MARK: Base ViewModel

class CCTableViewViewModelSection: CCViewModelSection {
    
}

//  MARK: Expanded ViewModel

enum CCTableViewViewModelExpandedState {
    case expanded
    case collapsed
}

protocol CCTableViewViewModelExpandedSectionOutputProtocol: class {
    func stateDidChange(state: CCTableViewViewModelExpandedState, viewModel: CCTableViewViewModelExpandedSection)
}

class CCTableViewViewModelExpandedSection: CCTableViewViewModelSection {
    
    private weak var output:    CCTableViewViewModelExpandedSectionOutputProtocol?
    private var state:          CCTableViewViewModelExpandedState?
    
    convenience init(output: CCTableViewViewModelExpandedSectionOutputProtocol? = nil,
                     state: CCTableViewViewModelExpandedState = .expanded,
                     id: String?,
                     nibId: String,
                     nibType: CCViewModelCellViewSourceType,
                     height: Float) {
        
        self.init(id: id, nibId: nibId, nibType: nibType, height: height)
        
        self.output = output
        self.state = state
    }
    
    //  MARK: Public
    
    public func changeState() {
        guard let state = self.state else {
            return
        }
        
        
        if state == .expanded {
            self.state = .collapsed
        } else {
            self.state = .expanded
        }
        
        self.output?.stateDidChange(state: state, viewModel: self)
    }
    
}
