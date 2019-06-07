//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: BasicTableViewPresenter

protocol CCTableViewPresenterProtocol: CCTableViewRefreshOutputProtocol, CCTableViewDelegateOutputProtocol {
    
}

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenterProtocol {
    
    //  MARK: Properties
    
    var manager: CCManagerProtocol
    
    //  MARK: Lifecycle
    
    init() {
        self.manager = CCTableViewManager(output: self)
        self.initializationModels()
    }
    
    func initializationModels() {
        
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, id: String?) {
        
    }
    
    //  MARK: CCTemplateViewModelsHandlerProtocol
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels, PaginationType>: CCTableViewPresenter<T>, CCTableViewPrefetchOutputProtocol {
    
    var pagination: CCPaginationModel = CCPaginationModel<PaginationType>()
    
    //  MARK: CCTableViewControllerPrefetchOutputProtocol
    
    func numberRowsInItem(by index: Int) -> Int {
        return manager.countCells(in: index)
    }
    
    func batchList() {
        
    }

}
