//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewModelCellOutputProtocol: class {
    func viewDidChange()
    func modelDidChage()
}

class CCViewModelCell: CCViewModel {
    
    //  MARK: Private
    
    internal var output:     CCViewModelCellOutputProtocol?
    
    //  MARK: Lifecycle
    
    init(output: CCViewModelCellOutputProtocol?, nibId: String, nibType: CCViewModelCellViewSourceType, height: Float) {
        self.output = output
        
        super.init(nibId: nibId, nibType: nibType, height: height)
    }
    
    required init(nibId: String, nibType: CCViewModelCellViewSourceType, height: Float) {
        super.init(nibId: nibId, nibType: nibType, height: height)
    }
    
}
