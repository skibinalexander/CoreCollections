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
        delegateOutput: DelegateOutputProtocol,
        viewDelegate: ManagerContextViewCallbackProtocol
    ) {
        super.init(
            dataSource: CollectionViewDataSource(),
            delegate: CollectionViewDelegate(output: delegateOutput),
            viewDelegate: viewDelegate
        )
    }
}
