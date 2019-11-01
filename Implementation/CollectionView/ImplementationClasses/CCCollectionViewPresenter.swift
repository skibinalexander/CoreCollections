//
//  CCCollectionViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - BasicCollectionViewPresenter

protocol CCCollectionViewPresenterProtocol: CCContainerViewRefreshOutputProtocol, CCCollectionViewDelegateOutputProtocol, CCViewModelOutputProtocol {
    
}

class CCCollectionViewPresenter<T: CCTemplateViewModels>: CCCollectionViewPresenterProtocol {
    
    // MARK: - Properties
    var manager: CCManagerProtocol!
    
    // MARK: - Lifecycle
    init() {
        self.manager = CCCollectionViewManager<T>(delegateOutput: self, cellOutput: self)
        self.initializationModels()
    }
    
    // MARK: - 
    func initializationModels() { }
    
    // MARK: - CCCollectionViewDelegateOutputProtocol
    func didSelect(indexPath: IndexPath, model: CCModelProtocol?) { }
    func willDisplay(indexPath: IndexPath, model: CCModelProtocol?) { }
    
    // MARK: - CCTemplateViewModelsHandlerProtocol
    func modelDidChange(viewModel: CCViewModelProtocol) { }
}

class CCPaginationCollectionViewPresenter<T: CCTemplateViewModels, PaginationType>: CCCollectionViewPresenter<T>, CCContainerViewPrefetchOutputProtocol {
    // MARK: - Properties
    var pagination: CCPaginationModel = CCPaginationModel<PaginationType>()
    
    // MARK: - CCCollectionViewControllerPrefetchOutputProtocol
    func batchNumberRows(in section: Int) -> Int {
        manager.item(index: section).cells.count
    }
    
    func batchList() {
        
    }
    
    // MARK: -
    func refreshList() {
        pagination = CCPaginationModel()
    }
    
}
