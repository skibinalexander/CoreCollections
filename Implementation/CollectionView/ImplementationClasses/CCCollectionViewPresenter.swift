//
//  CCCollectionViewPresenter.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCCollectionViewPresenter<T: CCTemplateViewModels> {
    
    
    init() {
//        self.dataSource = CCTableViewDataSource<T>(output: self)
//        self.delegate   = CCTableViewDelegate(template: self.dataSource?.template, output: self)
    }
}

//  MARK: CCViewModelCellOutputProtocol

extension CCCollectionViewPresenter: CCViewModelCellOutputProtocol {
    
    func viewDidChange(view: CCViewCellProtocol?, model: CCModelCellProtocol?) {
        
    }
    
    func modelDidChage(view: CCViewCellProtocol?, model: CCModelCellProtocol?) {
        
    }
    
}
