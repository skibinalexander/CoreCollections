//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCTableViewPresenterViewInputProtocol: class {
    func configure(dataSource: Any?, delegate: Any?, output: CCTableViewControllerOutputProtocol?)
    func configurePagination()
    func configureRefresh()
    
    func reloadTableView()
    
    func insertCellsIntoTableView(at paths: [IndexPath])
    func removeCellsIntoTableView(at paths: [IndexPath])
    func reloadCellsIntoTableView(at paths: [IndexPath])
    
    func updateHieghtCell(at paths: [IndexPath])
}

//  MARK: BasicTableViewPresenter

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewDelegateOutputProtocol, CCTemplateViewModelsDataSource {
    
    //  MARK: Properties
    
    var dataSource: (CCDataSourceExecuteViewModelsCellsProtocol & CCDataSourceReloadViewModelsCellsProtocol & CCDataSourceUpdateViewModelsCellsProtocol)?
    var delegate:   CCTableViewDelegateProtocol?
    
    private weak var tableViewInput: CCTableViewPresenterViewInputProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.dataSource = CCTableViewDataSource<T>(templateDataSource: self, output: self)
        self.delegate   = CCTableViewDelegate(cellsExecutor: self.dataSource,  output: self)
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(cell: CCTableViewViewModelCell?, at indexPath: IndexPath, id: String?) {
        
    }
    
}

//  MARK: Final

extension CCTableViewPresenter {
    
    final func configure(tableView: CCTableViewPresenterViewInputProtocol?, tableViewOutput: CCTableViewControllerOutputProtocol?) {
        self.tableViewInput = tableView
        self.tableViewInput?.configure(dataSource: self.dataSource, delegate: self.delegate, output: tableViewOutput)
    }
    
    final func configurePagination() {
        self.tableViewInput?.configurePagination()
    }
    
    final func reloadTableView() {
        self.tableViewInput?.reloadTableView()
    }
    
    final func insertNewCellsTableView() {
        guard let insertedCells = self.dataSource?.insertCells() else { return }
        self.tableViewInput?.insertCellsIntoTableView(at: insertedCells)
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

class CCPaginationTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenter<T> {
    var pagination: CCPaginationModel   = CCPaginationModel()
    var items: [CCTableViewModelCell]   = []
}
