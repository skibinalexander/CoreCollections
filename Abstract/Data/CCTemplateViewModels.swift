//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: class {
    var items: [CCItemModel] { get set }
}

protocol CCTemplateViewModelsProtocol: class {
    var isRefreshing: Bool { get set }
    var viewModels: [CCItemViewModel] { get set }
}

class CCTemplateViewModels: CCTemplateViewModelsProtocol {
    
    private weak var dataSource:    CCTemplateViewModelsDataSource?
    internal weak var output:       CCViewModelOutputProtocol?
    
    var viewModels: [CCItemViewModel] = []
    var isRefreshing: Bool = false
    
    internal var createHeader: ((_ model: CCModelSectionProtocol?) -> CCViewModelSectionProtocol?)?
    internal var createFooter: ((_ model: CCModelSectionProtocol?, _ index: Int) -> CCViewModelSectionProtocol?)?
    internal var createCell: ((_ model: CCModelCellProtocol?) -> CCViewModelCellProtocol)?
    
    required init(output: CCViewModelOutputProtocol?, dataSource: CCTemplateViewModelsDataSource) {
        self.output = output
        self.dataSource = dataSource
    }
    
}

// MARK: - Sections

extension CCTemplateViewModels {
    final func reloadViewModelsItems() {
        self.viewModels = []
        self.viewModels = dataSource?.items.map { _ in CCItemViewModel() } ?? []
        reloadViewModelSections()
        reloadViewModelsCells()
    }
    
    final func reloadViewModelSections() {
        dataSource?.items.enumerated().forEach { (index, element) in
            self.viewModels[index].header = self.createHeader?(element.header)?.inject(with: element.header, output: self.output)
            self.viewModels[index].footer = self.createFooter?(element.footer, index)?.inject(with: element.footer, output: self.output)
        }
        
        self.viewModels.forEach { (item) in
            item.header?.reference(item: item)
            item.footer?.reference(item: item)
        }
    }
    
    final func reloadViewModelsCells() {
        self.viewModels.forEach({$0.cells = []})
        
        dataSource?.items.enumerated().forEach({ (section, element) in
            element.cells.enumerated().forEach({ (index, model) in
                if let viewModel = self.createCell?(model) {
                    viewModel.indexSection = section
                    viewModel.indexRow = index
                    viewModel.output = output
                    viewModel.inject(model: model)
                    self.viewModels[section].cells.append(viewModel)
                } else {
                    fatalError()
                }
            })
        })
        
        self.viewModels.forEach { (item) in
            item.cells.forEach({ $0?.reference(item: item)})
        }
    }
}

// MARK: - Cells

extension CCTemplateViewModels {
    final func insertCells() -> [IndexPath] {
        var paths = [IndexPath]()
        
        dataSource?.items.enumerated().forEach({ (position, item) in
            item.cells.enumerated().forEach({ (index, model) in
                if model?.viewModel == nil {
                    if let viewModel = self.createCell?(model) {
                        viewModel.output = output
                        viewModel.inject(model: model)
                        viewModel.reference(item: self.viewModels[position])
                        self.viewModels[position].cells.insert(viewModel, at: index)
                        paths.append(IndexPath(row: index, section: position))
                    }
                }
            })
        })
        
        viewModels.enumerated().forEach { (position, item) in
            item.cells.enumerated().forEach { (index, viewModel) in
                viewModel?.indexSection = position
                viewModel?.indexRow = index
            }
        }
        
        return paths
    }
    
    final func removeCell() -> [IndexPath] {
        var paths = [IndexPath]()
        
//        viewModels.enumerated().forEach { (position, item) in
//            item.cells.enumerated().forEach { (index, viewModel) in
//                if viewModel?.getModel == nil {
//                    paths.append(IndexPath(row: index, section: position))
//                    self.viewModels[position].cells.remove(at: index)
//                }
//            }
//        }
//        
//        // - Пересчитываем новые индексы
//        viewModels.enumerated().forEach { (position, item) in
//            item.cells.enumerated().forEach { (index, viewModel) in
//                viewModel?.indexSection = position
//                viewModel?.indexRow = index
//            }
//        }
        
        return paths
    }
    
    final func removeAllCell() -> [IndexPath] {
        var paths = [IndexPath]()
        
        viewModels.enumerated().forEach { (position, item) in
            item.cells.enumerated().forEach { (index, viewModel) in
                if viewModel?.getModel == nil { paths.append(IndexPath(row: index, section: position)) }
            }
            self.viewModels[position].cells.removeAll(where: { $0?.getModel == nil })
        }
        
        // - Пересчитываем новые индексы
        viewModels.enumerated().forEach { (position, item) in
            item.cells.enumerated().forEach { (index, viewModel) in
                viewModel?.indexSection = position
                viewModel?.indexRow = index
            }
        }
        
        return paths
    }
}
