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
    
    func reloadList()
}

class CCTableViewPresenter<T: CCTemplateViewModels>:
                                CCTableViewPresenterProtocol,
                                CCTableViewDelegateOutputProtocol,
                                CCTemplateViewModelsDataSource,
                                CCTableViewRefreshOutputProtocol,
                                CCViewModelCellOutputProtocol {
    
    var itemsCells:     [CCModelCellProtocol]      = []
    var itemsSections:  [CCModelSectionProtocol]   = []
    
    
    //  MARK: Properties
    
    var dataSource: (CCDataSourceExecuteViewModelsSectionsProtocol &
                        CCDataSourceExecuteViewModelsCellsProtocol &
                        CCDataSourceReloadViewModelsCellsProtocol &
                        CCDataSourceUpdateViewModelsCellsProtocol)?
    
    var delegate:   CCTableViewDelegateProtocol?
    
    weak var tableViewInput: CCTableViewPresenterViewInputProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.dataSource = CCTableViewDataSource<T>(templateDataSource: self, output: self)
        self.delegate   = CCTableViewDelegate(sectionsExecutor: self.dataSource,
                                              cellsExecutor: self.dataSource,
                                              output: self)
        
        self.initFillSections()
        self.initFillCells()
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(indexPath: IndexPath, id: String?) {
        
    }
    
    //  MARK: Initial filling
    
    @objc dynamic func initFillSections() {
        
    }
    
    @objc dynamic func initFillCells() {
        
    }
    
    //  MARK: CCViewModelCellOutputProtocol
    
    func viewDidChange() {
        
    }
    
    func modelDidChage() {
        
    }
    
    //  MARK: CCTableViewRefreshOutputProtocol
    
    func refreshList() {
        self.itemsCells = []
        self.dataSource?.reload()
        self.tableViewInput?.reloadTableView()
        self.becomeViewRefresing()
    }
    
}


//  MARK:

extension CCTableViewPresenter {
    
    //
    
    final func reloadList() {
        self.dataSource?.reloadSections()
        self.dataSource?.reloadCells()
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
    
    final func becomeViewRefresing() {
        self.tableViewInput?.becomeRefresing()
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
    
    func countList() -> Int {
        return itemsCells.count
    }
    
    override func refreshList() {
        super.refreshList()
        self.pagination = CCPaginationModel()
        self.fetchList()
    }

}
