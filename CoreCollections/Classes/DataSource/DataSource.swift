//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовая реализация интерфейса DataSource
public class DataSource: NSObject {
    
    // MARK: - Public Properties
    
    var canMoveAtRow: Bool = false
    
    // MARK: - Private Properties7
    
    weak var mapper: MapperViewModels!
    
}
