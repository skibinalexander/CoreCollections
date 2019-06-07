//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCDataSourceProtocol {
    var models: [CCItemModel]   { get set }
}

//  MARK: DataSource

class CCDataSource<TemplateU: CCTemplateViewModels>: NSObject, CCTemplateViewModelsDataSource, CCDataSourceProtocol {
    
    //  Public Properties
    
    public var models:      [CCItemModel]
    
    //  MARK: Private Properties
    
    internal var template:  CCTemplateViewModels?
    
    //  MARK: Lifecycle
    
    init(handler: CCTemplateViewModelsHandlerProtocol, output: CCViewModelCellOutputProtocol) {
        self.models = []
        super.init()
        self.template = TemplateU(handler: handler, output: output, dataSource: self)
    }
    
}
