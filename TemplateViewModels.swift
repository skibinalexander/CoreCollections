//
//  TemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовый интерфейс реализации источника данных шаблона коллекции
///
/*
    Данный интерфейс описывает поведение коллекции при обращении стандартных
    DataSource (UITableView / UICollectionView)
 */
public protocol TemplateViewModelsDataSource: AnyObject {
    
    /// Набор item коллекции
    var items: [ItemModel] { get }
    
}

/// Базовая реализация шаблона маппинга ViewModel к Model
public class TemplateViewModels {
    
    // MARK: - Public Properties
    
    public weak var dataSource: TemplateViewModelsDataSource?
    
    ///
    public var viewModels: [ItemViewModel] = []
    
    // MARK: - Private Properties
    
    /// Определение ViewModel по Model для header секции
    public var createHeader: ((_ model: ModelSectionProtocol?) -> ViewModelSectionProtocol?)?
    
    /// Определение ViewModel по Model для footer секции
    public var createFooter: ((_ model: ModelSectionProtocol?) -> ViewModelSectionProtocol?)?
    
    /// Определение ViewModel по Model для ячейки
    public var createCell: ((_ model: ModelCellProtocol?) -> ViewModelCellProtocol)?
    
    // MARK: =  Initialization
    
    required init(dataSource: TemplateViewModelsDataSource) {
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
    
    private func insertViewModelAndModelCell(viewModel: ViewModelCellProtocol, model: ModelCellProtocol, at indexPath: IndexPath) {
        guard let dataSource = self.dataSource, dataSource.items.count == viewModels.count else {
            return
        }
        
        viewModels[indexPath.section].cells.insert(viewModel, at: indexPath.row)
        dataSource.items[indexPath.section].cells.insert(model, at: indexPath.row)
    }
    
}

// MARK: - Sections

extension TemplateViewModels {
    
    final func reloadViewModelsItems() {
        self.viewModels = []
        self.viewModels = dataSource?.items.map { ItemViewModel(id: $0.id) } ?? []
        reloadViewModelSections()
        reloadViewModelsCells()
    }
    
    final func reloadViewModelSections() {
        dataSource?.items.enumerated().forEach { (index, element) in
            viewModels[index].header = self.createHeader?(element.header)?.inject(with: element.header) as? ViewModelSectionProtocol
            
            viewModels[index].footer = self.createFooter?(element.footer)?.inject(with: element.footer) as? ViewModelSectionProtocol
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

extension TemplateViewModels {
    
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

extension TemplateViewModels {
    
    public func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        if let movedViewModelCell = viewModels[sourceIndexPath.section].cells[sourceIndexPath.row],
           let movedModel: ModelCellProtocol = viewModels[sourceIndexPath.section].cells[sourceIndexPath.row]?.typealiasModel() {
            
            removeViewModelAndModelCell(at: sourceIndexPath)
            insertViewModelAndModelCell(viewModel: movedViewModelCell, model: movedModel, at: destinationIndexPath)
        } else {
            reloadViewModelsItems()
        }
    }
    
}
