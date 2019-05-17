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
    func section(at index: Int)     -> CCViewModelProtocol?
    func section(at id: String?)    -> CCViewModelProtocol?
    func index(at section: CCViewModelProtocol) -> Int?
}

//  MARK: Cells

protocol CCDataSourceExecuteViewModelsCellsProtocol: class {
    func cell(at indexPath: IndexPath)  -> CCViewModelProtocol?
    func cell(at id: String?)           -> CCViewModelProtocol?
    func cells(at paths: [IndexPath])   -> [CCViewModelProtocol]
    func cells(at ids: [String?])       -> [CCViewModelProtocol]
    func cells(in sectionId: String?)   -> [CCViewModelProtocol?]?
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

class CCDataSource<TemplateU: CCTemplateViewModels>: NSObject {
    
    //  MARK: Properties
    
    internal var template: CCTemplateViewModels
    
    //  MARK: Lifecycle
    
    init(templateDataSource: CCTemplateViewModelsDataSource, output: CCViewModelCellOutputProtocol?) {
        self.template = TemplateU(dataSource: templateDataSource, output: output)
    }
    
}

//  MARK: Implementation Sections

extension CCDataSource: CCDataSourceExecuteViewModelsSectionsProtocol {
    func section(at index: Int) -> CCViewModelProtocol? {
        return self.template.sections[index]
    }
    
    func section(at id: String?) -> CCViewModelProtocol? {
        return self.template.sections.first(where: { (section) -> Bool in
            return section.modelId == id
        })
    }
    
    func index(at section: CCViewModelProtocol) -> Int? {
        return self.template.sections.firstIndex(where: { (find) -> Bool in
            return section.modelId == find.modelId
        })
    }
}

//  MARK: Imeplementation Cells

extension CCDataSource: CCDataSourceExecuteViewModelsCellsProtocol {
    
    //  MARK: Cells
    
    public func cell(at indexPath: IndexPath) -> CCViewModelProtocol? {
        let section = self.template.sections[indexPath.section]
        let cells = self.template.cells.filter { (cell) -> Bool in
            if let model = cell.getModel as? CCTableViewModelCell {
                return model.sectionId == section.modelId
            }
            
            return false
        }
        
        return cells[indexPath.row]
    }
    
    public func cell(at id: String?) -> CCViewModelProtocol? {
        return self.template.cells.first(where: { (cell) -> Bool in
            return cell.modelId == id
        })
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
        let section = self.template.sections.first(where: {$0.modelId == sectionId})
        return self.template.cells.map({ (cell) -> CCViewModelProtocol? in
            if let model = cell.getModel as? CCModelCellProtocol {
                if model.sectionId == section?.modelId {
                    return cell
                }
            }
            
            return nil
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


