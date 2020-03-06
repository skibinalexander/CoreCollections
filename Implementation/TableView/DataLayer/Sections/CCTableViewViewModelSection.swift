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

// MARK: -
protocol CCTableViewViewModelExpandedSectionOutputProtocol {
    func stateDidChange(state: CCTableViewViewModelExpandedState, viewModel: CCViewModelProtocol)
}

protocol CCTableViewViewModelExpandedSectionProtocol {
    func changeState()
}

class CCTableViewViewModelExpandedSection<V: CCTableViewSection, M: CCTableViewModelSection>: CCTableViewViewModelSection<V, M>, CCTableViewViewModelExpandedSectionProtocol {
    // MARK: - Properties
    internal var state: CCTableViewViewModelExpandedState?
    
    // MARK: - Lifecycle
    convenience init(state: CCTableViewViewModelExpandedState = .expanded, nibType: CCViewModelCellViewSourceType, height: CCViewModelHeight) {
        self.init(nibType: nibType, height: height)
        self.state = state
    }
    
    // MARK: - Public Implementation
    public func changeState() {
        guard let state = self.state else { return }
        self.state = state == .expanded ? .collapsed : .expanded
        
//        self.updateModel(parameters: ["state": self.state ?? .expanded, "id": model?.id ?? ""])
    }
    
}
