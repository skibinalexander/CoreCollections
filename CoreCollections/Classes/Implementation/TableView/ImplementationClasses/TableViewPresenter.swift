//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicTableViewPresenter

open class TableViewPresenter:
    TableViewDelegateProtocol,
    ContainerViewRefreshOutputProtocol,
    ManagerContextViewCallbackProtocol{
    
    // MARK: - Properties
    
    public var manager: ManagerProtocol!
    
    // MARK: - TableViewDelegateProtocol Properties
    
    public var editingStyle: UITableViewCell.EditingStyle = .none
    public var shouldIndentWhileEditingRowAt: Bool = false
    public var leadingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? = nil
    public var trailingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? = nil
    
    // MARK: - Lifecycle
    
    public init() {
        self.manager = Manager(
            dataSource: TableViewDataSource(),
            delegate: TableViewDelegate(
                output: self
            ),
            viewDelegate: self
        )
    }
    
    open func willDisplay(viewModel: ViewModelCellProtocol) { }
    open func didSelect(viewModel: ViewModelCellProtocol) { }
    open func didDeselect(viewModel: ViewModelCellProtocol) { }
    open func scrollDidChange() { }
    open func scrollViewDidEndScrollingAnimation() { }
    
    open func refreshList() {
        manager.beginRefresh()
    }
}

open class PaginationTableViewPresenter:
    TableViewPresenter,
    ContainerViewPrefetchOutputProtocol {
    
    open func batchNumberRows(in section: Int) -> Int {
        manager.item(index: section).cells.count
    }
    
    open func batchList() {}
    
    public func paginationInsertCells(in item: ItemModel, cells: [ModelCellProtocol]) {
        if item.cells.count > 0 {
            manager.getData().insertCells(in: item, cells: cells, by: item.cells.count - 1)
        } else {
            manager.getData().replaceCells(in: item, cells: cells, viewCallback: .reloadCollection)
        }
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
