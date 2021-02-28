//
//  CCTableViewManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCTableViewManager<T: TemplateViewModels>: Manager<T> {
    init(delegateOutput: CCTableViewDelegateOutputProtocol, viewDelegate: ManagerContextViewCallbackProtocol) {
        super.init()
        
        self.template = T(dataSource: self)
        self.dataSource = CCTableViewDataSource(template: template)
        self.delegate = CCTableViewDelegate(output: delegateOutput, template: template)
        self.viewDelegate = viewDelegate
        self.template.dataSource = self
    }
}
