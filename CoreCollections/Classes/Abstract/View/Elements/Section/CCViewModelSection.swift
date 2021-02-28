//
//  CCViewModelSection.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовая вью-модель секции (header / footer)
protocol CCViewModelSectionProtocol: CCViewModelProtocol {
    
}

class CCViewModelSection<V: CCViewSectionProtocol, M: CCModelSectionProtocol>: CCViewModel<V, M>, CCViewModelSectionProtocol {
    
}
