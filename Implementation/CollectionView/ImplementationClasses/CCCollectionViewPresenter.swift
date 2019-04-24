//
//  CCCollectionViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCCollectionViewPresenter<T: CCTemplateViewModels> {
    var dataSource: CCTableViewDataSource<T>?
    var delegate:   CCTableViewDelegate?
    
    init() {
        self.dataSource = CCTableViewDataSource<T>(output: self)
        self.delegate   = CCTableViewDelegate()
    }
}

//  MARK: CCViewModelCellOutputProtocol

extension CCCollectionViewPresenter: CCViewModelCellOutputProtocol {
    
    func viewDidChange() {
        
    }
    
    func modelDidChage() {
        
    }
    
}
