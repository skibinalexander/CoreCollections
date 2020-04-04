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
    func willDisplay(viewModel: CCViewModelProtocol) { }
    func didSelect(viewModel: CCViewModelProtocol) { }
    func didDeselect(viewModel: CCViewModelProtocol) { }
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
            manager.getData().replaceCells(in: item, cells: cells)
        }
    }
}

extension CCCollectionViewPresenter: CCManagerContextViewCallbackProtocol {
    func didInsertCells(paths: [IndexPath]) {
        manager.getView().insertCells(at: paths)
    }
    
    func didReplaceCells() {
        manager.endRefresh()
        manager.getView().reloadContainer()
    }
}
