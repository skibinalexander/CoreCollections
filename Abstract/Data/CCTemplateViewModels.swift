//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: class {
    var itemsCells:     [CCModelCellProtocol]      { get set }
    var itemsSections:  [CCModelSectionProtocol]   { get set }
}

class CCTemplateViewModels {
    var sections:   [CCViewModelSection]
    var cells:      [CCViewModelCell]
    
    private     weak var dataSource:    CCTemplateViewModelsDataSource?
    internal    weak var output:        CCViewModelCellOutputProtocol?
    
    var createCell: ((CCModelCellProtocol, Int)->(CCTableViewViewModelCell)?)?
    var createSection: ((CCModelSectionProtocol, Int)->(CCTableViewViewModelSection)?)?
    
    required init(dataSource: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.dataSource = dataSource
        self.output = output
        self.sections = []
        self.cells = []
    }
    
}

//  MARK: Sections

extension CCTemplateViewModels {
    
    final func reloadSections() {
        self.sections = []
        
        let _ = dataSource?.itemsSections.enumerated().map { (index, element) in
            if let section = self.createSection?(element, index) {
                section.inject(model: element)
                self.sections.append(section)
            }
        }
        
    }
    
}

//  MARK: Cells

extension CCTemplateViewModels {
    
    final func reloadCells() {
        self.cells = []
        
        let _ = dataSource?.itemsCells.enumerated().map({ (index, element) in
            if let cell = self.createCell?(element, index) {
                if self.sections.firstIndex(where: {$0.id == cell.sectionId}) != nil {
                    cell.inject(model: element)
                    self.cells.insert(cell, at: index)
                }
            }
        })
        
    }
    
    final func insertCells() -> [IndexPath] {
        
        var paths = [IndexPath]()

        let _ = dataSource?.itemsCells.enumerated().map { (index, element) in
            if element.viewModel == nil {
                if let cell = self.createCell?(element, index) {
                    if let sectionIndex = self.sections.firstIndex(where: {$0.id == cell.sectionId}) {
                        paths.append(IndexPath(row: index, section: sectionIndex))
                        cell.inject(model: element)
                        self.cells.insert(cell, at: index)
                    }
                }
            }
        }
        
        return paths
        
    }
    
    final func removeCells() -> [IndexPath] {
        
        var paths = [IndexPath]()
        
        let _ = self.cells.enumerated().map { (index, cell) in
            if cell.model == nil {
                if let sectionIndex = self.sections.firstIndex(where: {$0.id == cell.sectionId}) {
                    paths.append(IndexPath(row: index, section: sectionIndex))
                }
            }
        }
        
        self.cells.removeAll(where: { $0.model == nil })
        
        return paths
        
    }
    
}
