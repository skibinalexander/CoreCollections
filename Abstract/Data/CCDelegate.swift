//
//  CCDelegate.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCDelegate: NSObject {
    
    //  MARK: Properties
    
    internal var sectionsExecutor: CCDataSourceExecuteViewModelsSectionsProtocol?
    internal var cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?
    
    //  MARK: Lifecycle
    
    init(sectionsExecutor: CCDataSourceExecuteViewModelsSectionsProtocol?, cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?) {
        self.sectionsExecutor = sectionsExecutor
        self.cellsExecutor = cellsExecutor
    }
    
}
