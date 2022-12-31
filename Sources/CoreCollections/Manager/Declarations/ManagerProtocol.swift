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
    
    /// Набор Item в текущем контексте коллекции
    var items: [ItemViewModel] { get set }
    
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
    
    // - Access to ViewModels
    
    /// Найти первую view model ячейки по id во всех items
    /// - Parameter id: Идентификатор ячейки
    /// 
    /// Warning: вернется первая ячейка во всех item найденному по id. Быть внимательными если исполузуются одинаковые id для ячеек
    func resolveCell<V: ViewModelProtocol>(viewModel type: V.Type, by id: any Identifiable, at index: Int) throws -> V?
    
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
