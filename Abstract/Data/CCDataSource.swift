//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

//  MARK: Sections

protocol CCDataSourceExecuteItemsProtocol: class {
    func item(at index: Int)     -> CCItemViewModel?
    func item(at id: String?)    -> CCItemViewModel?
    
    func reload()
}

//  MARK: Cells

protocol CCDataSourceExecuteCellsProtocol: class {
    func cell(at indexPath: IndexPath)  -> CCViewModelProtocol?
    func cell(at id: String?)           -> CCViewModelProtocol?
    func cells(at paths: [IndexPath])   -> [CCViewModelProtocol]
    func cells(at ids: [String?])       -> [CCViewModelProtocol]
    func cells(in sectionId: String?)   -> [CCViewModelProtocol?]?
    
    func reloadCells()
    func insertCells() -> [IndexPath]
    func removeCells() -> [IndexPath]
}

//  MARK: DataSource

class CCDataSource<TemplateU: CCTemplateViewModels>: NSObject {
    
    //  MARK: Properties
    
    internal var template: CCTemplateViewModels
    
    //  MARK: Lifecycle
    
    init(template: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.template = TemplateU(dataSource: template, output: output)
    }
    
}

//  MARK: Implementation Sections

extension CCDataSource: CCDataSourceExecuteItemsProtocol {
    func item(at index: Int) -> CCItemViewModel? {
        return self.template.items[index]
    }
    
    func item(at id: String?) -> CCItemViewModel? {
        return self.template.items.first(where: { $0.id == id })
    }
}

//  MARK: Imeplementation Cells

extension CCDataSource: CCDataSourceExecuteCellsProtocol {
    
    //  MARK: Cells
    
    public func cell(at indexPath: IndexPath) -> CCViewModelProtocol? {
        return self.template.items[indexPath.section].cells[indexPath.row]
    }
    
    public func cell(at id: String?) -> CCViewModelProtocol? {
//        return template.items.map({ (item) -> CCViewModelProtocol? in
//            return item.cells.first(where: {$0?.modelId == id})
//        })
        
        return nil
    }
    
    public func cells(at paths: [IndexPath]) -> [CCViewModelProtocol] {
        return []
    }
    
    public func cells(at ids: [String?]) -> [CCViewModelProtocol] {
//        let _ = self.template.cells.mapValues({ (cells) in
//            return cells.filter({ (cell) -> Bool in
//                return ids.contains(cell.modelId)
//            })
//        })
        
        return []
    }
    
    public func cells(in sectionId: String?) -> [CCViewModelProtocol?]? {
//        let section = self.template.sections.first(where: {$0.modelId == sectionId})
//        return self.template.cells.map({ (cell) -> CCViewModelProtocol? in
//            if let model = cell.getModel as? CCModelCellProtocol {
//                if model.sectionId == section?.modelId {
//                    return cell
//                }
//            }
//            
//            return nil
//        })
        
        return nil
    }
    
}

//  MARK: ReloadCells

extension CCDataSource {
    
    func reload() {
        self.template.reloadItems()
    }
    
    func reloadCells() {
        self.template.reloadCells()
    }
    
}

//  MARK: UpdateCells

extension CCDataSource {
    
    func insertCells() -> [IndexPath] {
        return self.template.insertCells()
    }
    
    func removeCells() -> [IndexPath] {
        return self.template.removeCells()
    }
    
    func updateCells() -> ([IndexPath], [IndexPath]) {
        return (self.template.insertCells(), self.template.removeCells())
    }
    
}

//  MARK: UpdateCells

extension CCDataSource {
    
    public func updateViewModelCell(at indexPath: IndexPath) {
//        let cell = self.cell(at: indexPath)
//        cell?.updateView()
//        cell?.updateModel()
        
    }
    
    public func updateViewModelCell(at paths: [IndexPath]) {
        let _ = paths.map { (path) in
            self.updateViewModelCell(at: path)
        }
    }
    
    public func updateViewModelCell(at id: String?) {
//        let cell = self.cell(at: id)
//        cell?.updateView()
//        cell?.updateModel()
    }
    
    public func updateViewCell(at ids: [String]) {
        let _ = ids.map { (id) in
            self.updateViewModelCell(at: id)
        }
    }
    
}


