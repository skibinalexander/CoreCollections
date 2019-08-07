//
//  CCTableViewViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

// MARK: - Base ViewModel

class CCTableViewViewModelSection<V: CCTableViewSection, M: CCTableViewModelSection>: CCViewModelSection<V, M> {
    
}

// MARK: - Expanded ViewModel

public enum CCTableViewViewModelExpandedState {
    case expanded
    case collapsed
}

protocol CCTableViewViewModelExpandedSectionOutputProtocol: class {
    func stateDidChange(state: CCTableViewViewModelExpandedState, viewModel: CCViewModelProtocol)
}

protocol CCTableViewViewModelExpandedSectionProtocol {
    func changeState()
}

class CCTableViewViewModelExpandedSection<V: CCTableViewSection, M: CCTableViewModelSection>: CCTableViewViewModelSection<V, M>, CCTableViewViewModelExpandedSectionProtocol {
    
    private weak var output:    CCTableViewViewModelExpandedSectionOutputProtocol?
    internal var state:         CCTableViewViewModelExpandedState?
    
    convenience init(output: CCTableViewViewModelExpandedSectionOutputProtocol? = nil,
                     state: CCTableViewViewModelExpandedState = .expanded,
                     nibId: String,
                     nibType: CCViewModelCellViewSourceType,
                     height: CCViewModelHeight) {
        
        self.init(nibId: nibId, nibType: nibType, height: height)
        
        self.output = output
        self.state = state
    }
    
    // MARK: - Public
    
    public func changeState() {
        guard let state = self.state else {
            assert(true)
            return
        }
        
        if state == .expanded {
            self.state = .collapsed
        } else {
            self.state = .expanded
        }
        
        self.output?.stateDidChange(state: (self.state ?? .collapsed), viewModel: self)
    }
    
}
