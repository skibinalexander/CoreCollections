//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: class {
    var models:     [CCItemModel]      { get set }
}

class CCTemplateViewModels {
    var items:      [CCItemViewModel]
    
    private     weak var dataSource:    CCTemplateViewModelsDataSource?
    internal    weak var output:        CCViewModelCellOutputProtocol?
    
    internal var createHeader: ((_ model: CCModelSectionProtocol?, _ index: Int)    ->CCViewModelProtocol?)?
    internal var createFooter: ((_ model: CCModelSectionProtocol?, _ index: Int)    ->CCViewModelProtocol?)?
    internal var createCell: ((_ model: CCModelCellProtocol?, _ index: Int)         ->CCViewModelProtocol?)?
    
    required init(dataSource: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.dataSource = dataSource
        self.output = output
        self.items = []
    }
    
}

//  MARK: Sections

extension CCTemplateViewModels {
    
    final func reloadItems() {
        self.items = []
        
        let _ = dataSource?.models.enumerated().map { (index, element) in
            self.items.append(CCItemViewModel(header: self.createHeader?(element.header, index)?.inject(with: element.header),
                                              footer: self.createFooter?(element.footer, index)?.inject(with: element.footer)))
        }
        
        self.reloadCells()
        
        let _ = self.items.map { (item) in
            item.header?.reference(item: item)
            item.footer?.reference(item: item)
            item.cells.map({ [weak self] in $0?.reference(item: item)})
        }
    }
    
}

//  MARK: Cells

extension CCTemplateViewModels {
    
    final func reloadCells() {
        let _ = self.items.map({$0.cells = []})
        
        let _ = dataSource?.models.enumerated().map({ (section, element) in
            let _  = element.cells.enumerated().map({ (row, model) in
                self.items[section].cells.append(self.createCell?(model, row)?.inject(with: model))
            })
        })
        
    }
    
    final func insertCells() -> [IndexPath] {
        var paths = [IndexPath]()

//        let _ = dataSource?.itemsCells.enumerated().map { [unowned self] (index, element) in
//            if element.viewModel == nil {
//                if let cell = self.createCell?(element, index, self.cells.count) {
//                    if let model = cell.model as? CCModelCellProtocol {
//                        if let sectionIndex = self.sections.firstIndex(where: {$0.model?.modelId == model.sectionId}) {
//                            paths.append(IndexPath(row: index, section: sectionIndex))
//                            cell.inject(model: element)
//                            self.cells.insert(cell, at: index)
//                        }
//                    }
//                }
//            }
//        }
        
        return paths
        
    }
    
    final func removeCells() -> [IndexPath] {
        
        var paths = [IndexPath]()
        
//        let _ = self.cells.enumerated().map { (index, cell) in
//            if let model = cell.model as? CCModelCellProtocol {
//                if let sectionIndex = self.sections.firstIndex(where: {$0.model?.modelId == model.sectionId}) {
//                    paths.append(IndexPath(row: index, section: sectionIndex))
//                }
//            }
//        }
//
//        self.cells.removeAll(where: { $0.model == nil })
        
        return paths
        
    }
    
}
