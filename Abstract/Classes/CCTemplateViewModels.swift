//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCTemplateViewModels {
    var sections:   [CCViewModelSection]
    var cells:      [CCViewModelCell & CCViewModelBehaviorsCell]
    
    private weak var output: CCViewModelCellOutputProtocol?
    
    required init(output: CCViewModelCellOutputProtocol?) {
        self.output = output
        self.sections = []
        self.cells = []
    }
    
}

//  MARK: Override Reload Sections

extension CCTemplateViewModels {
    
    func reloadSections() {
        
    }
    
    func reloadSection(at index: Int) {
        
    }
    
    func reloadSection(at id: String?) {
        
    }
    
}

//  MARK: Override Reload Cells

extension CCTemplateViewModels {
    
    func reloadCells() {
        
    }
    
    func reloadCells(at indexs: [Int]) {
        
    }
    
    func reloadCells(at ids: [String]) {
        
    }
    
    func reloadCell(at index: Int) {
        
    }
    
    func reloadCell(at id: String?) {
        
    }
    
}
