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
    
    internal var cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?
    
    init(cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?) {
        self.cellsExecutor = cellsExecutor
    }
    
}