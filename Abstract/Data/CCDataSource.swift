//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

// MARK: - DataSource

protocol CCDataSourceProtocol: class {
    var canMoveAtRow: Bool { get set }
}

class CCDataSource: NSObject, CCDataSourceProtocol {
    
    // MARK: - Public Properties
    
    var canMoveAtRow: Bool = false
    
    // MARK: - Private Properties7
    
    internal weak var template: CCTemplateViewModelsProtocol?
    
    // MARK: - Lifecycle
    
    init(template: CCTemplateViewModelsProtocol) {
        super.init()
        self.template = template
    }
    
}
