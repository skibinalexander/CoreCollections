//
//  CCViewModelSection.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewModelSectionProtocol: CCViewModelProtocol {
    var cells: [CCViewModelProtocol] { get set }
    
    func clear()
}

class CCViewModelSection<V: CCViewSectionProtocol, M: CCModelSectionProtocol>:
                                                        CCViewModel<V, M>, CCViewModelSectionProtocol {
    public var cells: [CCViewModelProtocol] = []
    
    func clear() {
        self.cells = []
    }
}
