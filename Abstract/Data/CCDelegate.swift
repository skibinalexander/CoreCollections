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
    
    internal weak var executor: (CCDataSourceExecuteItemsViewModelsProtocol & CCDataSourceExecuteCellsViewModelsProtocol)?
    
    init(executor: (CCDataSourceExecuteItemsViewModelsProtocol & CCDataSourceExecuteCellsViewModelsProtocol)?) {
        self.executor = executor
    }
    
}
