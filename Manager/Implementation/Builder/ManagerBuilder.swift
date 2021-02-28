//
//  ManagerBuilder.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

/// Строитель для менеджера коллекции
public class ManagerBuilder {
    
    // MARK: - Private Properties
    
    private var manager: ManagerProtocol!
    private var containerData: ManagerContextProtocol!
    private var containerView: ContainerViewInputProtocol!
    private var viewDelegate: ManagerContextViewCallbackProtocol!
    private weak var prefetchOutput: ContainerViewPrefetchOutputProtocol?
    private weak var refreshOutput: ContainerViewRefreshOutputProtocol?
    private var items: [ItemModel] = []
    
    // MARK: Initialization
    
    init() {
        self.containerData = ManagerContext.newContext()
    }
    
    // MARK: - Configure
    
    final func configure(manager: ManagerProtocol) -> ManagerBuilder {
        self.manager = manager
        return self
    }
    
    final func configure(containerView: ContainerViewInputProtocol) -> ManagerBuilder {
        self.containerView = containerView
        return self
    }
    
    final func configure(containerData: ManagerContextProtocol) -> ManagerBuilder {
        self.containerData = containerData
        return self
    }
    
    final func configure(viewDelegate: ManagerContextViewCallbackProtocol) -> ManagerBuilder {
        self.viewDelegate = viewDelegate
        return self
    }
    
    final func configure(prefetch output: ContainerViewPrefetchOutputProtocol?) -> ManagerBuilder {
        self.prefetchOutput = output
        return self
    }
    
    final func configure(refresh output: ContainerViewRefreshOutputProtocol?) -> ManagerBuilder {
        self.refreshOutput = output
        return self
    }
    
    final func configure(items: [ItemModel]) -> ManagerBuilder {
        self.items.append(contentsOf: items)
        return self
    }
    
    // MARK: - Build
    
    /// Проставление зависимостей
    final func build() {
        containerData.set(viewDelegate: viewDelegate)
        
        containerView?.configure(
            dataSource: self.manager?.getDataSource(),
            delegate: self.manager?.getDelegate()
        )
        
        containerView?.configurePagination(output: prefetchOutput)
        containerView?.configureRefresh(output: refreshOutput)
        
        manager?.set(containerView: containerView)
        manager?.set(containerData: containerData ?? ManagerContext.newContext())
        
        manager?.append(items: self.items)
    }
    
}
