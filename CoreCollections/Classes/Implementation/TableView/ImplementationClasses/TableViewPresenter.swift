//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicTableViewPresenter

open class TableViewPresenter<T: TemplateViewModelsProtocol>:
    TableViewDelegateOutputProtocol,
    ContainerViewRefreshOutputProtocol,
    ManagerContextViewCallbackProtocol{
    
    // MARK: - Properties
    
    var manager: ManagerProtocol!
    
    // MARK: - Lifecycle
    
    init() {
        self.manager = TableViewManager(
            delegateOutput: self,
            viewDelegate: self,
            template: T.newTemplate()
        )
    }
    
    public func willDisplay(viewModel: ViewModelCellProtocol) { }
    public func didSelect(viewModel: ViewModelCellProtocol) { }
    public func didDeselect(viewModel: ViewModelCellProtocol) { }
    public func scrollDidChange() { }
    public func scrollViewDidEndScrollingAnimation() { }
    
    public func refreshList() {
        manager.beginRefresh()
    }
}

class CCPaginationTableViewPresenter<T: TemplateViewModelsProtocol>:
    TableViewPresenter<T>, ContainerViewPrefetchOutputProtocol {
    
    func batchNumberRows(in section: Int) -> Int {
        manager.item(index: section).cells.count
    }
    
    func batchList() {
        
    }
    
    func paginationInsertCells(in item: ItemModel, cells: [ModelCellProtocol]) {
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
