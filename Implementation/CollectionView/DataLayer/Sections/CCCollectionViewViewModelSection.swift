//
//  CCCollectionViewViewModelSection.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

// MARK: - Base ViewModel

class CCCollectionViewViewModelSection<V: CCCollectionViewSection, M: CCCollectionViewModelSection>: CCViewModelSection<V, M> {
    
}

// MARK: - Expanded ViewModel

public enum CCCollectionViewViewModelExpandedState {
    case expanded
    case collapsed
}

protocol CCCollectionViewViewModelExpandedSectionOutputProtocol: class {
    func stateDidChange(state: CCCollectionViewViewModelExpandedState, viewModel: CCViewModelProtocol)
}

protocol CCCollectionViewViewModelExpandedSectionProtocol: CCViewModelSectionProtocol {
    func changeState()
}

class CCCollectionViewViewModelExpandedSection<V: CCCollectionViewSection, M: CCCollectionViewModelSection>: CCCollectionViewViewModelSection<V, M>, CCCollectionViewViewModelExpandedSectionProtocol {
    
    internal var state:         CCCollectionViewViewModelExpandedState?
    
    convenience init(output: CCCollectionViewViewModelExpandedSectionOutputProtocol? = nil,
                     state: CCCollectionViewViewModelExpandedState = .expanded,
                     nibId: String,
                     nibType: CCViewModelCellViewSourceType,
                     height: CCViewModelHeight) {
        
        self.init(nibId: nibId, nibType: nibType, height: height)
        
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
        
//        self.output?.modelDidChange(state: (self.state ?? .collapsed), viewModel: self)
    }
    
}
