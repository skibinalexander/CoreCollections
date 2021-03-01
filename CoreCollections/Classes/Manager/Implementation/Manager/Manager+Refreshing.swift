//
//  Manager+Refreshing.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public extension Manager {
    
    func beginRefresh() {
        getData().refreshAllInAllItems()
        getView()?.beginRefreshing()
        isRefreshing = true
    }
    
    func endRefresh() {
        getView()?.endRefreshing()
        isRefreshing = false
    }
    
}
