//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCTemplateViewModelsDataSource: AnyObject {
    var items: [CCItemModel] { get }
}

protocol CCTemplateViewModelsProtocol: AnyObject {
    var viewModels: [CCItemViewModel] { get set }
    
    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
}

class CCTemplateViewModels: CCTemplateViewModelsProtocol {
    
    // MARK: - Public Properties
    
    public weak var dataSource: CCTemplateViewModelsDataSource?
    
    ///
    public var viewModels: [CCItemViewModel] = []
    
    // MARK: - Private Properties
    
    internal var createHeader: ((_ model: CCModelSectionProtocol?) -> CCViewModelSectionProtocol?)?
    internal var createFooter: ((_ model: CCModelSectionProtocol?, _ index: Int) -> CCViewModelSectionProtocol?)?
    internal var createCell: ((_ model: CCModelCellProtocol?) -> CCViewModelCellProtocol)?
    
    required init(dataSource: CCTemplateViewModelsDataSource) {
        self.dataSource = dataSource
    }
    
    // MARK: - Private Implementation
    
    private func removeViewModelAndModelCell(at indexPath: IndexPath) {
        guard let dataSource = self.dataSource, dataSource.items.count == viewModels.count else {
            return
        }
        
        viewModels[indexPath.section].cells.remove(at: indexPath.row)
        dataSource.items[indexPath.section].cells.remove(at: indexPath.row)
    }
    
    private func insertViewModelAndModelCell(viewModel: CCViewModelCellProtocol, model: CCModelCellProtocol, at indexPath: IndexPath) {
        guard let dataSource = self.dataSource, dataSource.items.count == viewModels.count else {
            return
        }
        
        viewModels[indexPath.section].cells.insert(viewModel, at: indexPath.row)
        dataSource.items[indexPath.section].cells.insert(model, at: indexPath.row)
    }
    
}

// MARK: - Sections

extension CCTemplateViewModels {
    
    final func reloadViewModelsItems() {
        self.viewModels = []
        self.viewModels = dataSource?.items.map { CCItemViewModel(id: $0.id) } ?? []
        reloadViewModelSections()
        reloadViewModelsCells()
    }
    
    final func reloadViewModelSections() {
        dataSource?.items.enumerated().forEach { (index, element) in
            self.viewModels[index].header = self.createHeader?(element.header)?.inject(with: element.header) as? CCViewModelSectionProtocol
            self.viewModels[index].footer = self.createFooter?(element.footer, index)?.inject(with: element.footer) as? CCViewModelSectionProtocol
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
                    viewModel.indexPath = IndexPath(row: index, section: section)
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
    /// Метод вставки конкретных моделей
    ///
    /// Работает по принципу поиска моделей которые добавлены но ViewModel отсутсвует
    /// - Алгоритм находит модели, которые уже добавлены без ViewModel  и помещает indexPath в массив
    /// - После того как собрали ViewModels требуется перестроить индексы в массиве ViewModels
    final func insertCells() -> [IndexPath] {
        var paths = [IndexPath]()
        
        dataSource?.items.enumerated().forEach({ (position, item) in
            item.cells.enumerated().forEach({ (index, model) in
                if model?.viewModel == nil {
                    if let viewModel = self.createCell?(model) {
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
                viewModel?.indexPath = IndexPath(row: index, section: position)
            }
        }
        
        return paths
    }
    
    /// Метод удаления всех ячеек по контексту удаленных моделей
    ///
    /// Работает по принципу удаления моделей в текщем контексте ViewModels
    /// - Алгоритм находит модели, которые уже удалены и помещает indexPath в массив
    /// - После того как алгоритм нашел удаленные модели и удалил ViewModel из массиа, нужно перестроить массив ViewModels
    final func removeCells() -> [IndexPath] {
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
                viewModel?.indexPath = IndexPath(row: index, section: position)
            }
        }
        
        return paths
    }
}

extension CCTemplateViewModels {
    
    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        if let movedViewModelCell = viewModels[sourceIndexPath.section].cells[sourceIndexPath.row],
           let movedModel: CCModelCellProtocol = viewModels[sourceIndexPath.section].cells[sourceIndexPath.row]?.typealiasModel() {
            
            removeViewModelAndModelCell(at: sourceIndexPath)
            insertViewModelAndModelCell(viewModel: movedViewModelCell, model: movedModel, at: destinationIndexPath)
        } else {
            reloadViewModelsItems()
        }
    }
    
}
