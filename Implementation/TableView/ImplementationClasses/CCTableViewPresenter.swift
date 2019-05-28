//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

//  MARK: BasicTableViewPresenter

protocol CCTableViewPresenterProtocol: class {
    var tableViewInput: CCTableViewPresenterViewInputProtocol?  { get set }
}

class CCTableViewPresenter<T: CCTemplateViewModels>:
                                CCTableViewPresenterProtocol,
                                CCTableViewDelegateOutputProtocol,
                                CCTableViewRefreshOutputProtocol  {
    
    //  MARK: Properties
    
    var dataSource: (CCDataSourceExecuteViewModelsProtocol & CCDataSourceExecuteCellsProtocol)?
    var delegate:   CCTableViewDelegateProtocol?
    
    weak var tableViewInput: CCTableViewPresenterViewInputProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.dataSource     = CCTableViewDataSource<T>(handler: self) as! (CCDataSourceExecuteCellsProtocol & CCDataSourceExecuteViewModelsProtocol)
        self.delegate       = CCTableViewDelegate(executor: self.dataSource, output: self)
        self.initModels()
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, id: String?) {
        
    }
    
    //  MARK: Initial filling
    
    @objc dynamic func initModels() {
        self.models = []
        guard self.models.count == 0 else {
            fatalError("CCTableViewPresenter already not empty")
        }
    }
    
    //  MARK: CCViewModelCellOutputProtocol
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) { }
    
    //  MARK: CCTableViewRefreshOutputProtocol
    
    func refreshList() {
        self.dataSource?.reload()
        self.tableViewInput?.reloadTableView()
        self.beginRefresging()
    }
    
}

extension CCTableViewPresenter: CCTemplateViewModelsHandlerProtocol {
    
    func templateViewModelsDidReload() {
        
    }
    
    func templateViewModelsDidInserted() -> [IndexPath] {
        
    }
    
    func templateViewModelsDidRemoved() -> [IndexPath] {
        
    }
    
}


//  MARK:

extension CCTableViewPresenter {
    
    //
    
    final func reloadList() {
        self.dataSource?.reload()
        self.tableViewInput?.reloadTableView()
    }
    
    final func reloadCells() {
        self.dataSource?.reloadCells()
        self.tableViewInput?.reloadTableView()
    }
    
    //
    
    final func updateCells() {
//        guard let insertedCells = self.dataSource?.insertCells() else { return }
//        guard let removedCells = self.dataSource?.removeCells() else { return }
//
//        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    final func insertCells() {
        guard let insertedCells = self.dataSource?.insertCells() else { return }
        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    final func removeCells() {
        guard let insertedCells = self.dataSource?.insertCells() else { return }
        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    //  
    
    final func beginRefresging() {
        self.tableViewInput?.beginRefresing()
    }
    
    final func endViewRefresing() {
        self.tableViewInput?.endRefresing()
    }
    
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenter<T>, CCTableViewPrefetchOutputProtocol {
    
    var pagination: CCPaginationModel   = CCPaginationModel()
    
    //  MARK: CCTableViewControllerPrefetchOutputProtocol
    
    func fetchList() {
        
    }
    
    func numberRows(in section: Int) -> Int {
        guard section < models.count else {
            assertionFailure()
            return 0
        }
        
        return models[section].cells.count
    }
    
    override func refreshList() {
        super.refreshList()
        self.pagination = CCPaginationModel()
        self.fetchList()
    }

}
