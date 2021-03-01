//
//  CCTableViewManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class TableViewManager: Manager {
    init(
        delegateOutput: TableViewDelegateOutputProtocol,
        viewDelegate: ManagerContextViewCallbackProtocol,
        template: TemplateViewModelsProtocol
    ) {
        super.init(
            dataSource: TableViewDataSource(),
            delegate: TableViewDelegate(output: delegateOutput),
            template: template,
            viewDelegate: viewDelegate
        )
    }
}
