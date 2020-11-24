//
//  CCManagerBuilder.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - CCManagerBuilder

class CCManagerBuilder {
    
    // MARK: - Private Properties
    
    private var manager: CCManagerProtocol!
    private var containerData: CCManagerContextProtocol!
    private var containerView: CCContainerViewInputProtocol!
    private var viewDelegate: CCManagerContextViewCallbackProtocol!
    private weak var prefetchOutput: CCContainerViewPrefetchOutputProtocol?
    private weak var refreshOutput: CCContainerViewRefreshOutputProtocol?
    private var items: [CCItemModel] = []
    
    // MARK: Init
    
    init() {
        self.containerData = CCManagerContext.newContext()
    }
    
    // MARK: - Configure
    
    final func configure(manager: CCManagerProtocol) -> CCManagerBuilder {
        self.manager = manager
        return self
    }
    
    final func configure(containerView: CCContainerViewInputProtocol) -> CCManagerBuilder {
        self.containerView = containerView
        return self
    }
    
    final func configure(containerData: CCManagerContextProtocol) -> CCManagerBuilder {
        self.containerData = containerData
        return self
    }
    
    final func configure(viewDelegate: CCManagerContextViewCallbackProtocol) -> CCManagerBuilder {
        self.viewDelegate = viewDelegate
        return self
    }
    
    final func configure(prefetch output: CCContainerViewPrefetchOutputProtocol?) -> CCManagerBuilder {
        self.prefetchOutput = output
        return self
    }
    
    final func configure(refresh output: CCContainerViewRefreshOutputProtocol?) -> CCManagerBuilder {
        self.refreshOutput = output
        return self
    }
    
    final func configure(items: [CCItemModel]) -> CCManagerBuilder {
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
        manager?.set(containerData: containerData ?? CCManagerContext.newContext())
        
        manager?.append(items: self.items)
    }
    
}
