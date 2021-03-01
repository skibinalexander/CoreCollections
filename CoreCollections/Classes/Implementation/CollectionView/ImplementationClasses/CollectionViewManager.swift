//
//  CCCollectionViewManager.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

public class CollectionViewManager: Manager {
    init(
        delegateOutput: CollectionViewDelegateOutputProtocol,
        viewDelegate: ManagerContextViewCallbackProtocol,
        template: TemplateViewModelsProtocol
    ) {
        super.init(
            dataSource: CollectionViewDataSource(),
            delegate: CollectionViewDelegate(output: delegateOutput),
            template: template,
            viewDelegate: viewDelegate
        )
    }
}
