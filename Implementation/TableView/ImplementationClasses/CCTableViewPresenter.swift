//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: BasicTableViewPresenter

protocol CCTableViewPresenterProtocol: CCTableViewRefreshOutputProtocol, CCTableViewDelegateOutputProtocol, CCTemplateViewModelsHandlerProtocol {
    var tableViewInput: CCTableViewPresenterViewInputProtocol?  { get set }
    
    func reloadTableView()
}

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenterProtocol {
    
    
    //  MARK: Properties
    
    weak var tableViewInput: CCTableViewPresenterViewInputProtocol?
    
    var dataSource: CCDataSourceProtocol?
    var delegate:   CCTableViewDelegateProtocol?
    
    //  MARK: Private
    
    var isRefresing: Bool
    
    //  MARK: Lifecycle
    
    init() {
        self.isRefresing = false
        
        self.dataSource     = CCTableViewDataSource<T>(handler: self)
        self.delegate       = CCTableViewDelegate(executor: self.dataSource, output: self)
        
        self.initializationModels()
    }
    
    @objc dynamic internal func initializationModels() {
        
    }
    
    //  MARK: CCTableViewRefreshOutputProtocol
    
    func refreshTableView() {
        self.beginViewRefresging()
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, id: String?) {
        
    }
    
    //  MARK: CCTemplateViewModelsHandlerProtocol
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    
    func templateViewModelsDidReload(paths: [IndexPath])    { }
    
    func templateViewModelsDidInserted(paths: [IndexPath]) {
        self.tableViewInput?.insertCellsIntoTableView(at: paths)
    }
    
    func templateViewModelsDidRemoved(paths: [IndexPath])   { }
    
}


//  MARK:

extension CCTableViewPresenter {
    
    //
    
    final func reloadTableView() {
        self.dataSource?.reload()
        self.tableViewInput?.reloadTableView()
    }
    
    //  
    
    final func beginViewRefresging() {
        self.isRefresing = true
        self.tableViewInput?.beginRefresing()
    }
    
    final func endViewRefresing() {
        self.tableViewInput?.endRefresing()
        self.isRefresing = false
    }
    
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenter<T>, CCTableViewPrefetchOutputProtocol {
    
    var pagination: CCPaginationModel   = CCPaginationModel()
    
    //  MARK: CCTableViewControllerPrefetchOutputProtocol
    
    func numberRows(in section: Int) -> Int {
        return dataSource?.cells(in: section).count ?? 0
    }
    
    override func refreshTableView() {
        super.refreshTableView()
        self.pagination = CCPaginationModel()
    }
    
    func batchList() {
        
    }

}
