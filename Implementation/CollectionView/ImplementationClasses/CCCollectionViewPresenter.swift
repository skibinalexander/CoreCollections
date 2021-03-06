//
//  CCCollectionViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicCollectionViewPresenter
protocol CCCollectionViewPresenterProtocol: CCContainerViewRefreshOutputProtocol, CCCollectionViewDelegateOutputProtocol {
    
}

class CCCollectionViewPresenter<T: CCTemplateViewModels>: CCCollectionViewPresenterProtocol, CCContainerViewRefreshOutputProtocol {
    
    // MARK: - Properties
    var manager: CCManagerProtocol!
    
    // MARK: - Lifecycle
    init() {
        self.manager = CCCollectionViewManager<T>(delegateOutput: self, viewDelegate: self)
        self.initializationItems()
    }
    
    func initializationItems() { }
    
    func refreshList() {
        manager.beginRefresh()
    }
    
    // MARK: - CCCollectionViewDelegateOutputProtocol
    func willDisplay(viewModel: CCViewModelCellProtocol) { }
    func didSelect(viewModel: CCViewModelCellProtocol) { }
    func didDeselect(viewModel: CCViewModelCellProtocol) { }
}

class CCPaginationCollectionViewPresenter<T: CCTemplateViewModels>: CCCollectionViewPresenter<T>, CCContainerViewPrefetchOutputProtocol {
    // MARK: - CCCollectionViewControllerPrefetchOutputProtocol
    func batchNumberRows(in section: Int) -> Int {
        manager.item(index: section).cells.count
    }
    
    func batchList() {
        
    }
    
    func paginationInsertCells(in item: CCItemModel, cells: [CCModelCellProtocol]) {
        if item.cells.count > 0 {
            manager.getData().insertCells(in: item, cells: cells, by: item.cells.count - 1)
        } else {
            manager.getData().replaceCells(in: item, cells: cells, viewCallback: .reloadCollection)
        }
    }
}

extension CCCollectionViewPresenter: CCManagerContextViewCallbackProtocol {
    func didUpdateView(with type: CCManagerContextViewCallbackType) {
        switch type {
        case .reloadInSection(let index): manager.getView().reloadCells(in: [index])
        default: manager.getView().reloadContainer()
        }
    }
    
    func didUpdateView(with type: CCManagerContextViewCallbackType, for paths: [IndexPath]) {
        switch type {
        case .insertIntoCollection: manager.getView().insertCells(at: paths)
        case .removeFromCollection: manager.getView().removeCells(at: paths)
        case .reloadInSection(let index): manager.getView().reloadCells(in: [index])
        default: manager.getView().reloadContainer()
        }
    }
}
