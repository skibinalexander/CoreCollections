//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: class {
    
}

class CCTemplateViewModels {
    var sections:   [CCViewModelSection]
    var cells:      [CCViewModelCell]
    
    internal var dataSource:     CCTemplateViewModelsDataSource
    private weak var output:    CCViewModelCellOutputProtocol?
    
    required init(dataSource: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.dataSource = dataSource
        self.output = output
        self.sections = []
        self.cells = []
    }
    
    func reloadSections() {
        self.sections = []
    }
    
    func reloadCells() {
        self.cells = []
    }
    
}
