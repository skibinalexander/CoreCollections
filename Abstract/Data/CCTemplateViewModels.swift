//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: class {
    var models: [CCItemModel] { get set }
}

protocol CCTemplateViewModelsHandlerProtocol: class {
    func templateViewModelsDidReload(paths: [IndexPath])
    func templateViewModelsDidInserted(paths: [IndexPath])
    func templateViewModelsDidRemoved(paths: [IndexPath])
}

protocol CCTemplateViewModelsProtocol: class {
    var viewModels: [CCItemViewModel]   { get set }
}

class CCTemplateViewModels: CCTemplateViewModelsProtocol {
    
    private weak var dataSource:    CCTemplateViewModelsDataSource?
    private weak var handler:       CCTemplateViewModelsHandlerProtocol?
    internal weak var output:        CCViewModelCellOutputProtocol?
    
    var viewModels: [CCItemViewModel] = []
    
    internal var createHeader: ((_ model: CCModelSectionProtocol?, _ index: Int)    ->CCViewModelProtocol?)?
    internal var createFooter: ((_ model: CCModelSectionProtocol?, _ index: Int)    ->CCViewModelProtocol?)?
    internal var createCell: ((_ model: CCModelCellProtocol?, _ index: Int)         ->CCViewModelProtocol?)?
    
    required init(handler: CCTemplateViewModelsHandlerProtocol, output: CCViewModelCellOutputProtocol, dataSource: CCTemplateViewModelsDataSource) {
        self.handler = handler
        self.output = output
        self.dataSource = dataSource
    }
    
}

//  MARK: Sections

extension CCTemplateViewModels {
    
    final func reloadViewModels() {
        self.viewModels = []
        
        dataSource?.models.enumerated().forEach { (index, element) in
            self.viewModels.append(CCItemViewModel(header: self.createHeader?(element.header, index)?.inject(with: element.header),
                                                   footer: self.createFooter?(element.footer, index)?.inject(with: element.footer)))
        }
        
        self.viewModels.forEach({$0.cells = []})
        
        dataSource?.models.enumerated().forEach({ (section, element) in
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
    
    final func insertCells() {
        var paths = [IndexPath]()
        
        dataSource?.models.enumerated().forEach({ (position, item) in
            item.cells.enumerated().forEach({ (index, model) in
                if model?.viewModel == nil {
                    if let viewModel = self.createCell?(model, index) {
                        viewModel.inject(model: model)
                        viewModel.reference(item: self.viewModels[position])
                        self.viewModels[position].cells.insert(viewModel, at: index)
                        paths.append(IndexPath(row: index, section: position))
                    }
                }
            })
        })
        
        handler?.templateViewModelsDidInserted(paths: paths)
        
    }
    
    final func removeCells() {
        
    }
    
}
