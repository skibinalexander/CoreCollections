//
//  CCTableViewManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCTableViewManager<T: CCTemplateViewModels>: CCManager<T> {
    
    init(delegateOutput: CCTableViewDelegateOutputProtocol, cellOutput: CCViewModelCellOutputProtocol) {
        self.dataSource = CCTableViewDataSource(handler: self, output: cellOutput)
        self.delegate   = CCTableViewDelegate(output: self)
    }
    
}
