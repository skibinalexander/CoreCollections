//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

//  MARK: Sections

protocol CCDataSourceExecuteViewModelsSectionsProtocol: class {
    func section<T: CCViewModelSection>(at index: Int) -> T?
    func section<T: CCViewModelSection>(at id: String?) -> T?
    func index(at section: CCViewModelSection) -> Int?
}

//  MARK: Cells

protocol CCDataSourceExecuteViewModelsCellsProtocol: class {
    func cell<T: CCViewModelCell>(at indexPath: IndexPath) -> T?
    func cell<T: CCViewModelCell>(at id: String?) -> T?
    func cells<T: CCViewModelCell>(at paths: [IndexPath]) -> [T]
    func cells(at ids: [String?]) -> [CCViewModelCell]
    func cells<T: CCViewModelCell>(in sectionId: String?) -> [T]?
}

protocol CCDataSourceReloadViewModelsCellsProtocol: class {
    func reload()
    func reloadSections()
    func reloadCells()      //  Reload all cells with binding models
}

protocol CCDataSourceUpdateViewModelsCellsProtocol: class {
    func insertCells() -> [IndexPath]
    func removeCells() -> [IndexPath]
}

//  MARK: DataSource

class CCDataSource<T: CCTemplateViewModels>: NSObject {
    
    //  MARK: Properties
    
    internal var template: CCTemplateViewModels
    
    //  MARK: Lifecycle
    
    init(templateDataSource: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.template = T(dataSource: templateDataSource, output: output)
    }
    
}

//  MARK: Implementation Sections

extension CCDataSource: CCDataSourceExecuteViewModelsSectionsProtocol {
    func section<T: CCViewModelSection>(at index: Int) -> T? {
        return self.template.sections[index] as? T
    }
    
    func section<T: CCViewModelSection>(at id: String?) -> T? {
        return self.template.sections.first(where: { (section) -> Bool in
            return section.model?.modelId == id
        }) as? T
    }
    
    func index(at section: CCViewModelSection) -> Int? {
        return self.template.sections.firstIndex(where: { (find) -> Bool in
            return section.model?.modelId == find.model?.modelId
        })
    }
}

//  MARK: Imeplementation Cells

extension CCDataSource: CCDataSourceExecuteViewModelsCellsProtocol {
    
    //  MARK: Cells
    
    public func cell<T: CCViewModelCell>(at indexPath: IndexPath) -> T? {
        let section = self.template.sections[indexPath.section]
        let cells = self.template.cells.filter({ (cell) -> Bool in
            if let model = cell.model as? CCModelCellProtocol {
                return model.sectionId == section.model?.modelId
            }
            
            return false
        })
        
        
        guard cells.count > indexPath.row else {
            assert(cells.count > indexPath.row, "Count Cells = \(cells.count)")
            return nil
        }
        
        return cells[indexPath.row] as? T
    }
    
    public func cell<T: CCViewModelCell>(at id: String?) -> T? {
        return self.template.cells.first(where: { (cell) -> Bool in
            return cell.model?.modelId == id
        }) as? T
    }
    
    public func cells<T: CCViewModelCell>(at paths: [IndexPath]) -> [T] {
        return []
    }
    
    public func cells(at ids: [String?]) -> [CCViewModelCell] {
        return self.template.cells.filter({ (cell) -> Bool in
            return ids.contains(cell.model?.modelId)
        })
    }
    
    public func cells<T>(in sectionId: String?) -> [T]? where T : CCViewModelCell {
        return self.template.cells.filter({ (cell) -> Bool in
            if let model = cell.model as? CCTableViewModelCell {
                return model.sectionId == sectionId
            }
            
            return false
        }) as? [T]
    }
    
}

//  MARK: ReloadCells

extension CCDataSource: CCDataSourceReloadViewModelsCellsProtocol {
    
    func reload() {
        self.reloadSections()
        self.reloadCells()
    }
    
    func reloadSections() {
        self.template.reloadSections()
    }
    
    func reloadCells() {
        self.template.reloadCells()
    }
    
}

//  MARK: UpdateCells

extension CCDataSource: CCDataSourceUpdateViewModelsCellsProtocol {
    
    func updateCells() -> ([IndexPath], [IndexPath]) {
        return (self.template.insertCells(), self.template.removeCells())
    }
    
    func insertCells() -> [IndexPath] {
        return self.template.insertCells()
    }
    
    func removeCells() -> [IndexPath] {
        return self.template.removeCells()
    }
    
}

//  MARK: UpdateCells

extension CCDataSource {
    
    public func updateViewModelCell(at indexPath: IndexPath) {
        let cell = self.cell(at: indexPath)
        cell?.updateView()
        cell?.updateModel()
        
    }
    
    public func updateViewModelCell(at paths: [IndexPath]) {
        let _ = paths.map { (path) in
            self.updateViewModelCell(at: path)
        }
    }
    
    public func updateViewModelCell(at id: String?) {
        let cell = self.cell(at: id)
        cell?.updateView()
        cell?.updateModel()
    }
    
    public func updateViewCell(at ids: [String]) {
        let _ = ids.map { (id) in
            self.updateViewModelCell(at: id)
        }
    }
    
}


