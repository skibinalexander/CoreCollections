//
//  CCTableViewManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCTableViewManager<T: CCTemplateViewModels>: CCManager<T> {
    init(delegateOutput: CCTableViewDelegateOutputProtocol, viewDelegate: CCManagerContextViewCallbackProtocol) {
        super.init()
        
        self.dataSource = CCTableViewDataSource(template: template)
        self.delegate = CCTableViewDelegate(output: delegateOutput, template: template)
        self.viewDelegate = viewDelegate
        self.template = T(dataSource: self)
    }
}
