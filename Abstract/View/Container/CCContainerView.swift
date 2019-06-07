//
//  CCContainerCollection.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

@objc protocol CCContainerViewPrefetchOutputProtocol: class {
    func batchList()
    func numberRows(in section: Int) -> Int
}

@objc protocol CCContainerViewRefreshOutputProtocol: class {
    func refreshTableView()
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
