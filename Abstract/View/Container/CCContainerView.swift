//
//  CCContainerCollection.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCContainerViewPrefetchOutputProtocol: class {
    func batchList()
    func batchNumberRows(in section: Int) -> Int
}

protocol CCContainerViewRefreshOutputProtocol: class {
    func refreshList()
}

extension CCContainerViewRefreshOutputProtocol {
    func refreshList() {}
}

protocol CCContainerViewInputProtocol: class {
    func configure(dataSource: Any?, delegate: Any?)
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?)
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?)
    
    func beginRefreshing()
    func endRefreshing()
    
    func reloadContainer()
    
    func insertCells(at paths: [IndexPath])
    func removeCells(at paths: [IndexPath])
    func reloadCells(in sections: [Int])
    
    func updateHieghtCell(completion: (() -> Void)?)
}

extension CCContainerViewInputProtocol {
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?) {}
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?) {}
    
    func beginRefreshing() {}
    func endRefreshing() {}
    
    func insertCells(at paths: [IndexPath]) {}
    func removeCells(at paths: [IndexPath]) {}
    func reloadCells(in sections: [Int]) {}
    
    func updateHieghtCell(completion: (() -> Void)?) {}
}
