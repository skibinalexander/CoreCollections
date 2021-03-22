//
//  MapperViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовая реализация шаблона маппинга ViewModel к Model
open class MapperViewModels {
    
    // MARK: - Public Properties
    
    /// Источник данных моделей коллекции
    public weak var dataSource: MapperViewModelsDataSource?
    public var template: TemplateViewModelsProtocol
    
    /// Набор ViewModel для моделей
    public var viewModels: [ItemViewModel] = []
    
    // MARK: =  Initialization
    
    public required init(template: TemplateViewModelsProtocol) {
        self.template = template
    }
    
    // MARK: - Private Implementation
    
    private func removeViewModelAndModelCell(at indexPath: IndexPath) {
        guard let dataSource = self.dataSource, dataSource.items.count == viewModels.count else {
            assertionFailure()
            return
        }
        
        viewModels[indexPath.section].cells.remove(at: indexPath.row)
        dataSource.items[indexPath.section].cells.remove(at: indexPath.row)
    }
    
    private func insertViewModelAndModelCell(viewModel: ViewModelCellProtocol, model: ModelCellProtocol, at indexPath: IndexPath) {
        guard let dataSource = self.dataSource, dataSource.items.count == viewModels.count else {
            assertionFailure()
            return
        }
        
        viewModels[indexPath.section].cells.insert(viewModel, at: indexPath.row)
        dataSource.items[indexPath.section].cells.insert(model, at: indexPath.row)
    }
    
}

// MARK: - Sections

extension MapperViewModels {
    
    /// Перезагрузить состояние ViewModels для всех item
    final func reloadViewModelsItems() {
        self.viewModels = []
        self.viewModels = dataSource?.items.map { ItemViewModel(id: $0.id) } ?? []
        reloadViewModelSections()
        reloadViewModelsCells()
    }
    
    /// Перезагрузить состояние ViewModels для секций
    final func reloadViewModelSections() {
        dataSource?.items.enumerated().forEach { (index, element) in
            viewModels[index].header = self.template.createHeader?(element.header)?.inject(with: element.header) as? ViewModelSectionProtocol
            
            viewModels[index].footer = self.template.createFooter?(element.footer)?.inject(with: element.footer) as? ViewModelSectionProtocol
        }
        
        self.viewModels.forEach { (item) in
            item.header?.reference(item: item)
            item.footer?.reference(item: item)
        }
    }
    
    /// Перезагрузить состояние ViewModels для всех ячеек
    final func reloadViewModelsCells() {
        self.viewModels.forEach({$0.cells = []})
        
        dataSource?.items.enumerated().forEach({ (section, element) in
            element.cells.enumerated().forEach({ (index, model) in
                if let viewModel = self.template.createCell?(model) {
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

extension MapperViewModels {
    
    /// Метод вставки конкретных моделей
    ///
    /// Работает по принципу поиска моделей которые добавлены но ViewModel отсутсвует
    /// - Алгоритм находит модели, которые уже добавлены без ViewModel  и помещает indexPath в массив
    /// - После того как собрали ViewModels требуется перестроить индексы в массиве ViewModels
    final func insertAllCellsWhereViewModelIsEmpty() -> [IndexPath] {
        var paths = [IndexPath]()
        
        dataSource?.items.enumerated().forEach({ (position, item) in
            item.cells.enumerated().forEach({ (index, model) in
                if model?.viewModel == nil {
                    if let viewModel = self.template.createCell?(model) {
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
    final func removeAllCellsWhereModelIsEmpty() -> [IndexPath] {
        var paths = [IndexPath]()
        
        viewModels.enumerated().forEach { (position, item) in
            item.cells.enumerated().forEach { (index, viewModel) in
                if viewModel?.getModel == nil {
                    paths.append(IndexPath(row: index, section: position))
                }
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

extension MapperViewModels {
    
    /// Выполнить изменение порядка ViewModel для ячеек
    final func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        if let movedViewModelCell = viewModels[sourceIndexPath.section].cells[sourceIndexPath.row],
           let movedModel: ModelCellProtocol = viewModels[sourceIndexPath.section].cells[sourceIndexPath.row]?.typealiasModel() {
            
            removeViewModelAndModelCell(at: sourceIndexPath)
            insertViewModelAndModelCell(viewModel: movedViewModelCell, model: movedModel, at: destinationIndexPath)
        } else {
            reloadViewModelsItems()
        }
    }
    
}
