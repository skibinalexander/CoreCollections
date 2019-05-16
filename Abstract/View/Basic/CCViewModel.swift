//
//  CCViewModel.swift
//  PaginationTableView
//
//  Created by Пользователь on 26/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

//  MARK: Constants

public enum CCViewModelCellViewSourceType {
    case reusebleId
    case nibName
}

//  MARK: Protocols

protocol CCViewProtocol: class {
    var viewModel: CCViewModel?  { get set }
}

protocol CCModelProtocol: class {
    var viewModel:  CCViewModel?    { get set }
    var modelId:    String?         { get set }
}

class CCViewModel {
    
    //  MARK: Private
    
    weak var view:          CCViewProtocol?
    weak var model:         CCModelProtocol?
    
    //  MARK: Public
    
    var nibId:              String
    var nibType:            CCViewModelCellViewSourceType
    var height:             Float
    
    //  MARK: Initialization
    
    required init(nibId: String, nibType: CCViewModelCellViewSourceType, height: Float) {
        self.nibId = nibId
        self.nibType = nibType
        self.height = height
    }
    
    //  MARK: Setters
    
    func inject(model: CCModelProtocol?) {
        self.model = model
        self.model?.viewModel = self
    }
    
    func inject(view: CCViewProtocol?) {
        self.view = view
        self.view?.viewModel = self
    }
    
    //  MARK: UpdateView
    
    public func updateView() {
        
    }
    
    //  MARK: UpdateModel
    
    public func updateModel() {
        
    }
    
}
