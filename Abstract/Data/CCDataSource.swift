//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

//  MARK: CCDataSourceControlFlowProtocol

protocol CCDataSourceControlFlowProtocol {
    func clear()
    func reload()
    func insert(in id: String, cells: [CCModelCellProtocol?])
}

//  MARK: CCDataSourceExecuteCellsProtocol

protocol CCDataSourceExecuteViewModelsProtocol: class {
    func cell(at indexPath: IndexPath)  -> CCViewModelProtocol?
    func cell(at id: String?)           -> CCViewModelProtocol?
    func cells(in item: Int)            -> [CCViewModelProtocol?]
    
    func item(at index: Int)     -> CCItemViewModel?
    func item(at id: String?)    -> CCItemViewModel?
}

protocol CCDataSourceProtocol: CCDataSourceControlFlowProtocol, CCDataSourceExecuteViewModelsProtocol {
    var models: [CCItemModel]   { get set }
}

//  MARK: DataSource

class CCDataSource<TemplateU: CCTemplateViewModels>: NSObject, CCTemplateViewModelsDataSource, CCDataSourceProtocol {
    
    //  Public Properties
    
    public var models:      [CCItemModel]
    
    //  MARK: Private Properties
    
    internal var template:  CCTemplateViewModels?
    
    //  MARK: Lifecycle
    
    init(handler: CCTemplateViewModelsHandlerProtocol, models: [CCItemModel] = [CCItemModel.empty()]) {
        self.models = models
        
        super.init()
        
        self.template = TemplateU(handler: handler, dataSource: self)
        self.template?.reloadViewModels()
    }
    
}

//  MARK: Implementation Sections

extension CCDataSource {
    func item(at index: Int) -> CCItemViewModel? {
        return self.template?.viewModels[index]
    }
    
    func item(at id: String?) -> CCItemViewModel? {
        return self.template?.viewModels.first(where: { $0.id == id })
    }
}

//  MARK: Imeplementation Cells

extension CCDataSource {
    
    //  MARK: Cells
    
    public func cell(at indexPath: IndexPath) -> CCViewModelProtocol? {
        return self.template?.viewModels[indexPath.section].cells[indexPath.row]
    }
    
    public func cell(at id: String?) -> CCViewModelProtocol? {
        var cell: CCViewModelProtocol?
        self.template?.viewModels.forEach { (item) in
            if let find = item.cells.first(where: { $0?.modelId == id }) as? CCViewModelProtocol {
                cell = find
            }
        }
        
        return cell
    }
    
    public func cells(in itemPath: Int) -> [CCViewModelProtocol?] {
        return self.template?.viewModels[itemPath].cells ?? []
    }
    
}

//  MARK:

extension CCDataSource {
    
    func clear() {
        self.models = []
        self.template?.reloadViewModels()
    }
    
    func reload() {
        self.template?.reloadViewModels()
    }
    
    func insert(in id: String, cells: [CCModelCellProtocol?]) {
        if let item = self.models.first(where: {$0.id == id}) {
            if item.cells.count > 0 {
                item.cells.insert(contentsOf: cells, at: item.cells.count - 1)
            } else {
                item.cells.insert(contentsOf: cells, at: 0)
            }
        }
        
        self.template?.insertCells()
    }
    
}
