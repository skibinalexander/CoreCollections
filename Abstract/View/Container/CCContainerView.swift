//
//  CCContainerCollection.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCContainerViewPrefetchOutputProtocol: class {
    func batchList(in containerView: CCContainerViewInputProtocol)
    func numberRows(in section: Int, in containerView: CCContainerViewInputProtocol) -> Int
}

protocol CCContainerViewRefreshOutputProtocol: class {
    func refreshList(in containerView: CCContainerViewInputProtocol)
}

protocol CCContainerViewInputProtocol: class {
    func configure(dataSource: Any?, delegate: Any?)
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?)
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?)
    
    func beginRefresing()
    func endRefresing()
    
    func reloadContainer()
    
    func insertCellsIntoTableView(at paths: [IndexPath])
    func removeCellsIntoTableView(at paths: [IndexPath])
    func reloadCellsIntoTableView(at paths: [IndexPath])
    
    func updateHieghtCell(completion: (()->Void)?)
}
