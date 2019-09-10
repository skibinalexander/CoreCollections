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

extension CCContainerViewPrefetchOutputProtocol {
    func batchList(in containerView: CCContainerViewInputProtocol) { }
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
    
    func insertCells(at paths: [IndexPath])
    func removeCells(at paths: [IndexPath])
    func reloadCells(in sections: [Int])
    
    func updateHieghtCell(completion: (() -> Void)?)
}

extension CCContainerViewInputProtocol {
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?) {}
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?) {}
    
    func beginRefresing() {}
    func endRefresing() {}
    
    func insertCells(at paths: [IndexPath]) {}
    func removeCells(at paths: [IndexPath]) {}
    func reloadCells(in sections: [Int]) {}
    
    func updateHieghtCell(completion: (() -> Void)?) {}
}
