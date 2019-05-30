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
    
    var dataSource: CCDataSourceProtocol?
    
    var delegate:   CCTableViewDelegateProtocol?
    
    weak var tableViewInput: CCTableViewPresenterViewInputProtocol?
    
    //  MARK: Lifecycle
    
    init() {
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
    func templateViewModelsDidInserted(paths: [IndexPath])  { }
    func templateViewModelsDidRemoved(paths: [IndexPath])   { }
    
}


//  MARK:

extension CCTableViewPresenter {
    
    //
    
    final func reloadTableView() {
        self.dataSource?.reloadDataSource()
        self.tableViewInput?.reloadTableView()
    }
    
    final func reloadCells() {
        
    }
    
    //
    
    final func updateCells() {
//        guard let insertedCells = self.dataSource?.insertCells() else { return }
//        guard let removedCells = self.dataSource?.removeCells() else { return }
//
//        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    final func insertCells() {
//        guard let insertedCells = self.dataSource?.insertCells() else { return }
//        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    final func removeCells() {
//        guard let insertedCells = self.dataSource?.insertCells() else { return }
//        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    //  
    
    final func beginViewRefresging() {
        self.tableViewInput?.beginRefresing()
    }
    
    final func endViewRefresing() {
        self.tableViewInput?.endRefresing()
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
        if pagination.hasMore ?? true {
            self.beginViewRefresging()
        }
    }

}
