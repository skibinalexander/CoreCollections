//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicTableViewPresenter

protocol CCTableViewPresenterProtocol:
    ContainerViewRefreshOutputProtocol, CCTableViewDelegateOutputProtocol {
    
}

class CCTableViewPresenter<T: TemplateViewModels>: CCTableViewPresenterProtocol, ContainerViewRefreshOutputProtocol {
    
    // MARK: - Properties
    
    var manager: ManagerProtocol!
    
    // MARK: - Lifecycle
    
    init() {
        self.manager = CCTableViewManager<T>(
            delegateOutput: self,
            viewDelegate: self
        )
    }
    
    func willDisplay(viewModel: ViewModelCellProtocol) { }
    func didSelect(viewModel: ViewModelCellProtocol) { }
    func didDeselect(viewModel: ViewModelCellProtocol) { }
    func scrollDidChange() { }
    func scrollViewDidEndScrollingAnimation() { }
    
    func refreshList() {
        manager.beginRefresh()
    }
}

class CCPaginationTableViewPresenter<T: TemplateViewModels>: CCTableViewPresenter<T>, ContainerViewPrefetchOutputProtocol {
    
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

extension CCTableViewPresenter: ManagerContextViewCallbackProtocol {
    
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
