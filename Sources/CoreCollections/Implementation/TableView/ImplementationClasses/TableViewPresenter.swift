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
    TableViewDelegateProtocol,
    ContainerViewRefreshOutputProtocol,
    ContainerViewPrefetchOutputProtocol,
    ManagerContextViewCallbackProtocol {
    
    // MARK: - Properties
    
    public var manager: ManagerProtocol!
    
    // MARK: - TableViewDelegateProtocol Properties
    
    public var editingStyle: UITableViewCell.EditingStyle = .none
    public var shouldIndentWhileEditingRowAt: Bool = false
    public var leadingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? = nil
    public var trailingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? = nil
    public var prefetchCallback: (() -> Void)? = nil
    
    // MARK: - Lifecycle
    
    public init() {
        self.manager = Manager(
            dataSource: TableViewDataSource(),
            delegate: TableViewDelegate(output: self),
            viewDelegate: self
        )
    }
    
    open func willDisplay(viewModel: ViewModelCellProtocol) {}
    open func didSelect(viewModel: ViewModelCellProtocol) {}
    open func didDeselect(viewModel: ViewModelCellProtocol) {}
    open func scrollDidChange() {}
    open func scrollViewDidEndScrollingAnimation() {}
    open func scrollViewDidEndDecelerating() {}
    open func scrollViewWillBeginDecelerating() {}
    open func batchOfPaths(paths: [IndexPath]) {}
    
    open func refreshList() {
        manager.beginRefresh()
    }

}

// MARK: - ManagerContextViewCallbackProtocol

public extension TableViewPresenter {
    
    func didUpdateView(with type: ManagerContextViewCallbackType) {
        switch type {
        case .reloadInSection(let index): manager.getView().reloadCells(in: [index])
        default: manager.getView().reloadContainer()
        }
    }
    
    func didUpdateView(with type: ManagerContextViewCallbackType, for paths: [IndexPath]) {
        switch type {
        case .insertIntoCollection: manager.getView().insertCells(at: paths)
        case .removeFromCollection: manager.getView().removeCells(at: paths)
        case .reloadInSection(let index): manager.getView().reloadCells(in: [index])
        default: manager.getView().reloadContainer()
        }
    }
    
}
