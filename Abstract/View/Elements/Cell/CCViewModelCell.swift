//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewModelCellOutputProtocol: class {
    func modelDidChage(viewModel: CCViewModelProtocol?)
}

class CCViewModelCell<V: CCViewCellProtocol, M: CCModelCellProtocol>: CCViewModel<V, M> {
    
    //  MARK: Private
    
    internal var output: CCViewModelCellOutputProtocol?
    
    //  MARK: Lifecycle
    
    init(output: CCViewModelCellOutputProtocol? = nil, nibId: String, nibType: CCViewModelCellViewSourceType, height: CCViewModelHeight) {
        self.output = output
        super.init(nibId: nibId, nibType: nibType, height: height)
    }
    
    override func updateView() {
        super.updateView()
        self.view?.output = self.output
    }
    
    override func updateModel() {
        super.updateModel()
        self.output?.modelDidChage(viewModel: self)
    }
    
}
