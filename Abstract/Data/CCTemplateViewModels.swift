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

protocol CCPaginationTemplateViewModelsDataSource: class {
    var items: [CCTableViewModelCell]   { get set }
}

class CCTemplateViewModels {
    var sections:   [CCViewModelSection]
    var cells:      [CCViewModelCell]
    
    internal var dataSource:    CCTemplateViewModelsDataSource
    private weak var output:    CCViewModelCellOutputProtocol?
    
    var createCell: ((CCTableViewModelCell)->(CCTableViewViewModelCell)?)?
    
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
    
    func insertCells() -> [IndexPath] {
        
        var paths = [IndexPath]()
        
        guard let dataSource = self.dataSource as? CCPaginationTemplateViewModelsDataSource else {
            return []
        }
        
        let insertModels = dataSource.items.filter { (item) -> Bool in
            return item.viewModel == nil
        }
        
        let _ = insertModels.map { (insert) in
            
            if let index = dataSource.items.firstIndex(where: { (first) -> Bool in
                return first === insert
            }) {
                paths.append(IndexPath(row: index, section: 0))
                if let cell = self.createCell?(insert) {
                    cell.inject(model: insert)
                    self.cells.insert(cell, at: index)
                }
            }
            
        }
        
        return paths
        
    }
    
}
