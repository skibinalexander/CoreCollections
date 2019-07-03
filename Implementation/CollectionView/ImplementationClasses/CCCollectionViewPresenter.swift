//
//  CCCollectionViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: BasicCollectionViewPresenter

protocol CCCollectionViewPresenterProtocol: CCContainerViewRefreshOutputProtocol, CCCollectionViewDelegateOutputProtocol, CCViewModelCellOutputProtocol {
    
}

class CCCollectionViewPresenter<T: CCTemplateViewModels>: CCCollectionViewPresenterProtocol {
    
    //  MARK: Properties
    
    var manager: CCManagerProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.manager = CCCollectionViewManager<T>(delegateOutput: self, cellOutput: self)
        self.initializationModels()
    }
    
    func initializationModels() { }
    
    //  MARK: CCCollectionViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, model: CCModelProtocol?)   { }
    func willDisplay(indexPath: IndexPath, model: CCModelProtocol?) { }
    
    //  MARK: CCTemplateViewModelsHandlerProtocol
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    
    //  MARK:
    
    func refreshList(in containerView: CCContainerViewInputProtocol) {
        
    }
    
}

class CCPaginationCollectionViewPresenter<T: CCTemplateViewModels, PaginationType>: CCCollectionViewPresenter<T>, CCContainerViewPrefetchOutputProtocol {
    
    var pagination: CCPaginationModel = CCPaginationModel<PaginationType>()
    
    //  MARK: CCCollectionViewControllerPrefetchOutputProtocol
    
    func batchList(in containerView: CCContainerViewInputProtocol) {
        
    }
    
    func numberRows(in section: Int, in containerView: CCContainerViewInputProtocol) -> Int {
        return manager?.countCells(in: section) ?? 0
    }
    
    //  MARK:
    
    override func refreshList(in containerView: CCContainerViewInputProtocol) {
        super.refreshList(in: containerView)
        pagination = CCPaginationModel()
    }
    
}
