//
//  CCTableViewViewModelSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

// MARK: - Base ViewModel

open class TableViewViewModelSection<V: TableViewSection, M: TableViewModelSection>:
    ViewModelSection<V, M> {
    
}

// MARK: - Expanded ViewModel

public enum TableViewViewModelExpandedState {
    case expanded
    case collapsed
}

open class TableViewViewModelExpandedSection<V: TableViewSection, M: TableViewModelSection>:
    TableViewViewModelSection<V, M> {
    
    // MARK: - Properties
    
    public var state: TableViewViewModelExpandedState?
    
    // MARK: - Lifecycle
    
    convenience init(
        state: TableViewViewModelExpandedState = .expanded,
        nibType: ViewModelCellViewSourceType, height: ViewModelHeight
    ) {
        self.init(nibType: nibType, height: height)
        self.state = state
    }
    
    // MARK: - Public Implementation
    
    public func changeState() {
        guard let state = self.state else { return }
        self.state = state == .expanded ? .collapsed : .expanded
    }
    
}
