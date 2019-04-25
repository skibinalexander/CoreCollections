//
//  CCTableViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCTableViewPresenter<T: CCTemplateViewModels>: CCTableViewDelegateOutputProtocol {
    
    //  MARK: Properties
    
    var dataSource: CCTableViewDataSource<T>?
    var delegate:   CCTableViewDelegate?
    
    //  MARK: Lifecycle
    
    init() {
        self.dataSource = CCTableViewDataSource<T>(output: self)
        self.delegate   = CCTableViewDelegate(template: self.dataSource?.template, output: self)
    }
    
    //  MARK: CCTableViewDelegateOutputProtocol
    
    func didSelect(cell: CCTableViewViewModelCell, at indexPath: IndexPath, id: String?) {
        
    }
    
}

//  MARK: CCViewModelCellOutputProtocol

extension CCTableViewPresenter: CCViewModelCellOutputProtocol {
    
    func viewDidChange() {
        
    }
    
    func modelDidChage() {
        
    }
    
}
