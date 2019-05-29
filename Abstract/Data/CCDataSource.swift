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
    func reloadDataSource()
    func insert(in itemId: String, cell: CCViewModelProtocol)
    func insert(in itemId: String, cells: [CCViewModelProtocol])
    func removeCell(from itemId: String)
}

//  MARK: CCDataSourceExecuteViewModelsProtocol

protocol CCDataSourceExecuteItemsViewModelsProtocol: class {
    func item(at index: Int)     -> CCItemViewModel?
    func item(at id: String?)    -> CCItemViewModel?
}

//  MARK: CCDataSourceExecuteCellsProtocol

protocol CCDataSourceExecuteCellsViewModelsProtocol: class {
    func cell(at indexPath: IndexPath)  -> CCViewModelProtocol?
    func cell(at id: String?)           -> CCViewModelProtocol?
    func cells(in item: Int)            -> [CCViewModelProtocol?]
}

protocol CCDataSourceProtocol: CCDataSourceControlFlowProtocol, CCDataSourceExecuteItemsViewModelsProtocol, CCDataSourceExecuteCellsViewModelsProtocol {
    var models: [CCItemModel]   { get set }
}

//  MARK: DataSource

class CCDataSource<TemplateU: CCTemplateViewModels>: NSObject, CCTemplateViewModelsDataSource, CCDataSourceProtocol {
    
    //  Public Properties
    
    public var models:      [CCItemModel]
    
    //  MARK: Private Properties
    
    internal var template:  CCTemplateViewModels?
    
    //  MARK: Lifecycle
    
    init(handler: CCTemplateViewModelsHandlerProtocol, models: [CCItemModel] = []) {
        self.models = models
        
        super.init()
        
        self.template = TemplateU(handler: handler, dataSource: self)
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
    
    func reloadDataSource() {
        self.template?.reloadViewModels()
    }
    
    func insert(in itemId: String, cell: CCViewModelProtocol) {
        
    }
    
    func insert(in itemId: String, cells: [CCViewModelProtocol]) {
        
    }
    
    func removeCell(from itemId: String) {
        
    }
    
    
}
