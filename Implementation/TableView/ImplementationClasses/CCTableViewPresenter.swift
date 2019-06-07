//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: BasicTableViewPresenter

protocol CCTableViewPresenterProtocol: CCTableViewRefreshOutputProtocol, CCTableViewDelegateOutputProtocol, CCViewModelCellOutputProtocol {
    
}

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenterProtocol {
    
    //  MARK: Properties
    
    var manager: CCManagerProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.manager = CCTableViewManager(delegateOutput: self, cellOutput: self)
        self.initializationModels()
    }
    
    func initializationModels() { }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, id: String?) { }
    
    //  MARK: CCTemplateViewModelsHandlerProtocol
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    
    //  MARK:
    
    func refreshTableView() { }
    
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels, PaginationType>: CCTableViewPresenter<T>, CCTableViewPrefetchOutputProtocol {
    
    var pagination: CCPaginationModel = CCPaginationModel<PaginationType>()
    
    //  MARK: CCTableViewControllerPrefetchOutputProtocol
    
    func numberRows(in index: Int) -> Int {
        return manager?.countCells(in: index) ?? 0
    }
    
    func batchList() {
        
    }

}
