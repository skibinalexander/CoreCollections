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

class CCTableViewPresenter<T: CCTemplateViewModels>:CCTableViewPresenterProtocol, CCTableViewDelegateOutputProtocol, CCTemplateViewModelsDataSource {
    
    var itemsCells:     [CCTableViewModelCell]      = []
    var itemsSections:  [CCTableViewModelSection]   = []
    
    
    //  MARK: Properties
    
    var dataSource: (CCDataSourceExecuteViewModelsCellsProtocol &
                    CCDataSourceReloadViewModelsCellsProtocol &
                    CCDataSourceUpdateViewModelsCellsProtocol)?
    
    var delegate:   CCTableViewDelegateProtocol?
    
    weak var tableViewInput: CCTableViewPresenterViewInputProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.dataSource = CCTableViewDataSource<T>(templateDataSource: self, output: self)
        self.delegate   = CCTableViewDelegate(cellsExecutor: self.dataSource,  output: self)
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(cell: CCTableViewViewModelCell?, at indexPath: IndexPath, id: String?) {
        
    }
    
}


//  MARK:

extension CCTableViewPresenter {
    
    final func reloadCells() {
        self.tableViewInput?.reloadTableView()
    }
    
    final func insertCells() {
        guard let insertedCells = self.dataSource?.insertCells() else { return }
        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
    }
    
    final func removeCells() {
        
    }
    
    final func becomeViewRefresing() {
        self.tableViewInput?.becomeRefresing()
    }
    
    final func endViewRefresing() {
        self.tableViewInput?.endRefresing()
    }
    
}

//  MARK: CCViewModelCellOutputProtocol

extension CCTableViewPresenter: CCViewModelCellOutputProtocol {
    
    func viewDidChange() {
        
    }
    
    func modelDidChage() {
        
    }
    
}

struct CCPaginationModel {
    var currentItem:    Int     = 0
    var countItems:     Int     = 0
    var itemsOnPage:    Int     = 0
    var hasMore:        Bool    = true
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenter<T>, CCTableViewPrefetchOutputProtocol {
    var pagination: CCPaginationModel   = CCPaginationModel()
    
    //  MARK: CCTableViewControllerPrefetchOutputProtocol
    
    func fetchList() {
        
    }
    
    func countList() -> Int {
        return itemsCells.count
    }

}
