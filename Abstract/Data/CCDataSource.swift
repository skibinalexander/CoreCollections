//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCDataSourceExecuteViewModelsCellsProtocol {
    func cell<T: CCViewModelCell>(at indexPath: IndexPath) -> T?
    func cell<T: CCViewModelCell>(at id: String?) -> T?
    func cells<T: CCViewModelCell>(at paths: [IndexPath]) -> [T]
    func cells(at ids: [String?]) -> [CCViewModelCell]
}

protocol CCDataSourceReloadViewModelsCellsProtocol {
    func reload()
    func reloadSections()
    func reloadCells()      //  Reload all cells with binding models
}

protocol CCDataSourceUpdateViewModelsCellsProtocol {
    func insertCells() -> [IndexPath]
}

class CCDataSource<T: CCTemplateViewModels>: NSObject {
    
    //  MARK: Properties
    
    internal var template: CCTemplateViewModels
    
    //  MARK: Lifecycle
    
    init(templateDataSource: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.template = T(dataSource: templateDataSource, output: output)
    }
    
}

//  MARK: Imeplementation

extension CCDataSource: CCDataSourceExecuteViewModelsCellsProtocol {
    
    //  MARK: Cells
    
    public func cell<T: CCViewModelCell>(at indexPath: IndexPath) -> T? {
        let section = self.template.sections[indexPath.section]
        let cells = self.template.cells.filter({ $0.sectionId == section.id })
        return cells[indexPath.row] as? T
    }
    
    public func cell<T: CCViewModelCell>(at id: String?) -> T? {
        return self.template.cells.first(where: { (cell) -> Bool in
            return cell.id == id
        }) as? T
    }
    
    public func cells<T: CCViewModelCell>(at paths: [IndexPath]) -> [T] {
        return []
    }
    
    public func cells(at ids: [String?]) -> [CCViewModelCell] {
        return self.template.cells.filter({ (cell) -> Bool in
            return ids.contains(cell.id)
        })
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
    
    func insertCells() -> [IndexPath] {
        return self.template.insertCells()
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


