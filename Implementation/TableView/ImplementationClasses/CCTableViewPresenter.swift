//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicTableViewPresenter

protocol CCTableViewPresenterProtocol: CCContainerViewRefreshOutputProtocol, CCTableViewDelegateOutputProtocol {
    
}

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenterProtocol, CCContainerViewRefreshOutputProtocol {
    // MARK: - Properties
    var manager: CCManagerProtocol!
    
    // MARK: - Lifecycle
    init() {
        self.manager = CCTableViewManager<T>(delegateOutput: self, viewDelegate: self)
        self.initializationItems()
    }
    
    func initializationItems() { }
    
    func refreshList() {
        manager.beginRefresh()
    }
    
    // MARK: - CCTableViewDelegateOutputProtocol
    func didSelect(indexPath: IndexPath, model: CCModelProtocol?) { }
    func didDeselect(indexPath: IndexPath, model: CCModelProtocol?) { }
    func willDisplay(indexPath: IndexPath, model: CCModelProtocol?) { }
    
    // MARK: -
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenter<T>, CCContainerViewPrefetchOutputProtocol {
    // MARK: - CCTableViewControllerPrefetchOutputProtocol
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

extension CCTableViewPresenter: CCManagerContextViewCallbackProtocol {
    func didInsertCells(paths: [IndexPath]) {
        manager.getView().insertCells(at: paths)
    }
    
    func didReplaceCells() {
        manager.endRefresh()
        manager.getView().reloadContainer()
    }
}
