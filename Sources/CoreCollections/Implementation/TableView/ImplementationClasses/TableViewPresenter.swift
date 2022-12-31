//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

// MARK: - BasicTableViewPresenter

open class TableViewPresenter:
    ManagerProtocol,
    DelegateOutputProtocol,
    ContainerViewOutputProtocol,
    ManagerContextViewCallbackProtocol {
    
    // MARK: - ManagerProtocol
    
    public var items: [ItemViewModel] = []
    public var isRefreshing: Bool = false
    public var dataSource: TableViewDataSource!
    public var delegate: TableViewDelegate!
    public var containerData: ContainerDataProtocol!
    public var containerView: ContainerViewInputProtocol!

    // MARK: - TableViewDelegateProtocol Properties
    
    public var editingStyle: UITableViewCell.EditingStyle = .none
    public var shouldIndentWhileEditingRowAt: Bool = false
    public var leadingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? = nil
    public var trailingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? = nil
    public var prefetchCallback: (() -> Void)? = nil
    
    // MARK: - Lifecycle
    
    public init() {
        
    }
    
    public func configuration() {
        self.dataSource = .init(nil, containerData: containerData)
        self.delegate = .init(nil, containerData: containerData, delegate: self)
        
        containerView.configure(
            dataSource: dataSource,
            delegate: delegate
        )
        
        containerView.configure(output: self)
    }
    
    open func refreshList() {
        self.beginRefresh()
    }
    
    public func beginRefresh() {}
    public func endRefresh() {}
    public func batchOfPaths(paths: [IndexPath]) {}

}

// MARK: - ManagerContextViewCallbackProtocol

public extension TableViewPresenter {
    
    func didUpdateView(with type: ManagerContextViewCallbackType) {
        switch type {
        case .reloadInSection(let index): containerView.reloadCells(in: [index])
        default: containerView.reloadContainer()
        }
    }
    
    func didUpdateView(with type: ManagerContextViewCallbackType, for paths: [IndexPath]) {
        switch type {
        case .insertIntoCollection: containerView.insertCells(at: paths)
        case .removeFromCollection: containerView.removeCells(at: paths)
        case .reloadInSection(let index): containerView.reloadCells(in: [index])
        default: containerView.reloadContainer()
        }
    }
    
}

extension TableViewPresenter {
    
    public func resolveCell<V: ViewModelProtocol>(viewModel type: V.Type, by id: any Identifiable, at index: Int) throws -> V? {
        return nil
    }
    
}

extension DelegateOutputProtocol {
    
}
