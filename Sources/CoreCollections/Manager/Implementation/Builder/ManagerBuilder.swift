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
    private var containerData: ContainerDataProtocol!
    private var containerViewInput: ContainerViewInputProtocol!
    private weak var containerViewOutput: ContainerViewOutputProtocol?
    private var viewDelegate: ManagerContextViewCallbackProtocol!
    
    // MARK: Initialization
    
    public init() {

    }
    
    // MARK: - Configure
    
    public final func configure(manager: ManagerProtocol) -> ManagerBuilder {
        self.manager = manager
        return self
    }
    
    public final func configure(containerView input: ContainerViewInputProtocol) -> ManagerBuilder {
        self.containerViewInput = input
        return self
    }
    
    public final func configure(containerView output: ContainerViewOutputProtocol?) -> ManagerBuilder {
        self.containerViewOutput = output
        return self
    }
    
    public final func configure(containerData: ContainerDataProtocol) -> ManagerBuilder {
        self.containerData = containerData
        return self
    }
    
    public final func configure(viewDelegate: ManagerContextViewCallbackProtocol) -> ManagerBuilder {
        self.viewDelegate = viewDelegate
        return self
    }
    
    public final func configure(items: [ItemViewModel]) -> ManagerBuilder {
        self.containerData.items = items
        return self
    }
    
    // MARK: - Build
    
    /// Проставление зависимостей
    public final func build() {
        
    }
    
}
