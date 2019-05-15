//
//  CCDelegate.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCDelegate: NSObject {
    
    //  Properties
    
    internal weak var cellsExecutor:    CCDataSourceExecuteViewModelsCellsProtocol?
    internal weak var sectionsExecutor: CCDataSourceExecuteViewModelsSectionsProtocol?
    
    init(sectionsExecutor: CCDataSourceExecuteViewModelsSectionsProtocol?, cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?) {
        self.sectionsExecutor = sectionsExecutor
        self.cellsExecutor = cellsExecutor
    }
    
}
