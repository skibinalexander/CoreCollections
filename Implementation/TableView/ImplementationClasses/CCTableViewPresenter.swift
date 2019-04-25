//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCTableViewPresenterViewInputProtocol: class {
    func configure(dataSource: Any, delegate: Any)
    func configureRefresh()
    func reloadTableView()
    func insertCellsIntoTableView(at paths: [IndexPath])
    func removeCellsIntoTableView(at paths: [IndexPath])
    func reloadCellsIntoTableView(at paths: [IndexPath])
    func updateHieghtCell(at paths: [IndexPath])
}

//  MARK: BasicTableViewPresenter

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewDelegateOutputProtocol {
    
    //  MARK: Properties
    
    var dataSource: CCDataSourceExecuteCellsProtocol?
    var delegate:   CCTableViewDelegateProtocol?
    
    //  MARK: Lifecycle
    
    init() {
        self.dataSource = CCTableViewDataSource<T>(output: self)
        self.delegate   = CCTableViewDelegate(cellsExecutor: self.dataSource,  output: self)
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(cell: CCTableViewViewModelCell?, at indexPath: IndexPath, id: String?) {
        
    }
    
}

//  MARK: CCViewModelCellOutputProtocol

extension CCTableViewPresenter: CCViewModelCellOutputProtocol {
    
    func viewDidChange() {
        
    }
    
    func modelDidChage() {
        
    }
    
}

//  MARK: PaginationTableView

protocol CCPaginationTableViewPresenterViewInputProtocol: CCTableViewPresenterViewInputProtocol {
    func configurePagination()
}

class CCPaginationModel {
    var currentItem:    Int
    var countItems:     Int
    var itemOnPage:     Int
    
    init(currentItem: Int = 0, countItems: Int = 0, itemOnPage: Int = 25) {
        self.currentItem = currentItem
        self.countItems = countItems
        self.itemOnPage = itemOnPage
    }
}

class CCPaginationTableViewPresenter<T: CCTemplateViewModels>: CCTableViewPresenter<T> {
    
    
}
