//
//  CCCollectionViewManager.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCCollectionViewManager<T: CCTemplateViewModels>: CCManager<T> {
    
    init(delegateOutput: CCCollectionViewDelegateOutputProtocol, cellOutput: CCViewModelCellOutputProtocol?) {
        super.init()
        
        self.template   = T(handler: self, output: cellOutput, dataSource: self)
        
        if let template = self.template {
            self.dataSource = CCCollectionViewDataSource(template: template)
            self.delegate   = CCCollectionViewDelegate(output: delegateOutput, template: template)
        } else {
            assertionFailure()
        }
    }
    
}
