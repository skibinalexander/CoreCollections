//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCTableViewPresenterViewInputProtocol: class {
    func configure(dataSource: CCTableViewDataSource<CCTemplateViewModels>, delegate: CCTableViewDelegate)
    func configurePagination()
    func configureRefresh()
    func reloadTableView()
    func insertCellsIntoTableView(at paths: [IndexPath])
    func removeCellsIntoTableView(at paths: [IndexPath])
    func reloadCellsIntoTableView(at paths: [IndexPath])
    func updateHieghtCell(at paths: [IndexPath])
}

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewDelegateOutputProtocol {
    
    //  MARK: Properties
    
    var dataSource: CCTableViewDataSource<T>?
    var delegate:   CCTableViewDelegate?
    
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
