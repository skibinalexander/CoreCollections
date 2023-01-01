//
//  ManagerProtocol.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - ManagerContextViewCallbackProtocol

public protocol ManagerContextViewCallbackProtocol: AnyObject {
    func didUpdateView(with type: ManagerContextViewCallbackType)
    func didUpdateView(with type: ManagerContextViewCallbackType, for paths: [IndexPath])
}

// MARK: - ManagerProtocol

public protocol ManagerProtocol {
    
    /// Refreshing state
    var isRefreshing: Bool { get set }
    
    /// Containers Data & View
    var containerData: ContainerDataProtocol! { get set }
    var containerView: ContainerViewInputProtocol! { get set }
    
    // MARK: - Implementation
    
    /// Конфигурация менеджера
    func configuration()
    
    // - Access to Refresh control flow
    func beginRefresh()
    func endRefresh()
    
}

extension ManagerProtocol {
    
    public mutating func beginRefresh() {
        guard !isRefreshing else {
            return
        }
        
        containerView.beginRefreshing()
        isRefreshing = true
    }
    
    mutating func endRefresh() {
        containerView.endRefreshing()
        isRefreshing = false
    }
    
}
