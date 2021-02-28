//
//  CCCollectionViewManager.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCCollectionViewManager<T: TemplateViewModels>: Manager<T> {
    init(delegateOutput: CCCollectionViewDelegateOutputProtocol, viewDelegate: ManagerContextViewCallbackProtocol) {
        super.init()
        
        self.template = T(dataSource: self)
        self.dataSource = CCCollectionViewDataSource(template: template)
        self.delegate = CCCollectionViewDelegate(output: delegateOutput, template: template)
        self.viewDelegate = viewDelegate
        self.template.dataSource = self
    }
}
