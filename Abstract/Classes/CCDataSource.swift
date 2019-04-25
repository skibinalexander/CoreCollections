//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCDataSourceExecuteCellsProtocol {
    func cell<T: CCViewModelCell>(at indexPath: IndexPath) -> T?
    func cell<T: CCViewModelCell>(at id: String?) -> T?
    func cells<T: CCViewModelCell>(at paths: [IndexPath]) -> [T]
    func cells(at ids: [String?]) -> [CCViewModelCell]
}

class CCDataSource<T: CCTemplateViewModels>: NSObject {
    
    //  MARK: Properties
    
    internal var template: CCTemplateViewModels
    
    //  MARK: Lifecycle
    
    init(output: CCViewModelCellOutputProtocol?) {
        self.template = T(output: output)
    }
    
}

//  MARK: Imeplementation

extension CCDataSource: CCDataSourceExecuteCellsProtocol {
    
    //  MARK: Cells
    
    public func cell<T: CCViewModelCell>(at indexPath: IndexPath) -> T? {
        return self.template.cells.first(where: { (cell) -> Bool in
            return self.template.sections[indexPath.section].id == cell.sectionId
        }) as? T
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

extension CCDataSource {
    
    public func reloadCell(at indexPath: IndexPath) {
        self.template.reloadCell(at: indexPath.section)
    }
    
    public func reloadCell(at id: String?) {
        self.template.reloadCell(at: id)
    }
    
    public func reloadCells() {
        self.template.reloadCells()
    }
    
    public func reloadCells(at paths: [IndexPath]) {
        self.template.reloadCells(at: paths.map({ (path) -> Int in
            return path.row
        }))
    }
    
    public func reloadCells(at ids: [String]) {
        self.template.reloadCells(at: ids)
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


