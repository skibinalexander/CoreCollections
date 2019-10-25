//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicTableViewPresenter

protocol CCTableViewPresenterProtocol: CCContainerViewRefreshOutputProtocol, CCTableViewDelegateOutputProtocol, CCViewModelOutputProtocol {
    
}

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenterProtocol, CCContainerViewRefreshOutputProtocol {
    
    // MARK: - Properties
    
    var manager: CCManagerProtocol!
    
    // MARK: - Lifecycle
    
    init() {
        self.manager = CCTableViewManager<T>(delegateOutput: self, cellOutput: self)
        self.initializationItems()
    }
    
    func initializationItems() { }
    
    // MARK: - CCTableViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, model: CCModelProtocol?) { }
    func willDisplay(indexPath: IndexPath, model: CCModelProtocol?) { }
    func modelDidChange(viewModel: CCViewModelProtocol) { }
    
    // MARK: -
    func refreshList() {
        manager.getContext().change(item: nil, type: .refresh, cells: [], nil)
    }
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels, PaginationType>: CCTableViewPresenter<T>, CCContainerViewPrefetchOutputProtocol {
    
    var pagination: CCPaginationModel = CCPaginationModel<PaginationType>()
    
    // MARK: - CCTableViewControllerPrefetchOutputProtocol
    func batchNumberRows(in section: Int, in containerView: CCContainerViewInputProtocol) -> Int {
        return manager.getContext().item(index: section)?.cells.count ?? 0
    }
    
    func batchList(in containerView: CCContainerViewInputProtocol) {
        
    }
    
    // MARK: -
    
    override func refreshList() {
        super.refreshList()
        pagination = CCPaginationModel()
    }

}
