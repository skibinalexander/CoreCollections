//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: class {
    var containerModels: CCItemModelsContainer { get set }
}

protocol CCTemplateViewModelsHandlerProtocol: CCTemplateViewModelsDataSource, CCViewModelCellOutputProtocol {
    func templateViewModelsDidReload()      -> [IndexPath]
    func templateViewModelsDidInserted()    -> [IndexPath]
    func templateViewModelsDidRemoved()     -> [IndexPath]
}

class CCTemplateViewModels {
    
    var viewModels: [CCItemViewModel] = []
    
    private weak var handler: CCTemplateViewModelsHandlerProtocol?
    
    internal var createHeader: ((_ model: CCModelSectionProtocol?, _ index: Int)    ->CCViewModelProtocol?)?
    internal var createFooter: ((_ model: CCModelSectionProtocol?, _ index: Int)    ->CCViewModelProtocol?)?
    internal var createCell: ((_ model: CCModelCellProtocol?, _ index: Int)         ->CCViewModelProtocol?)?
    
    required init(handler: CCTemplateViewModelsHandlerProtocol) {
        self.handler = handler
    }
    
}

//  MARK: Sections

extension CCTemplateViewModels {
    
    final func reloadViewModels() {
        self.viewModels = []
        
        handler?.containerModels.models.enumerated().forEach { (index, element) in
            self.viewModels.append(CCItemViewModel(header: self.createHeader?(element.header, index)?.inject(with: element.header),
                                                   footer: self.createFooter?(element.footer, index)?.inject(with: element.footer)))
        }
        
        self.viewModels.forEach({$0.cells = []})
        
        handler?.containerModels.models.enumerated().forEach({ (section, element) in
            element.cells.enumerated().forEach({ (row, model) in
                self.viewModels[section].cells.append(self.createCell?(model, row)?.inject(with: model))
            })
        })
        
        self.viewModels.forEach { (item) in
            item.header?.reference(item: item)
            item.footer?.reference(item: item)
            let _ = item.cells.map({ $0?.reference(item: item)})
        }
    }
    
}

//  MARK: Cells

extension CCTemplateViewModels {
    
    final func insertCells() -> [IndexPath] {
        var paths = [IndexPath]()

//        let _ = dataSource?.viewModelsCells.enumerated().map { [unowned self] (index, element) in
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
