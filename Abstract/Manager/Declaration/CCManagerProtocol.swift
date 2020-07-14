//
//  CCManagerProtocol.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

// MARK: - CCManagerContextViewCallbackProtocol
protocol CCManagerContextViewCallbackProtocol: class {
    func didUpdateView(with type: CCManagerContextViewCallbackType)
    func didUpdateView(with type: CCManagerContextViewCallbackType, for paths: [IndexPath])
}

// MARK: - CCManagerProtocol
protocol CCManagerProtocol: class {
    // MARK: - Setters
    func set(containerData: CCManagerContextProtocol?)
    func set(containerView: CCContainerViewInputProtocol?)
    
    // MARK: - Getters
    func getDataSource() -> CCDataSourceProtocol?
    func getDelegate() -> CCDelegate
    func getView() -> CCContainerViewInputProtocol!
    func getData() -> CCManagerContextProtocol
    
    // - Access to Refresh control flow
    func beginRefresh()
    func endRefresh()
    
    //  - Access to items
    func append(items: [CCItemModel])
    func append(item: CCItemModel)
    func replace(item: CCItemModel)
    func remove(item at: Int)
    func removeAll()
    
    func item(id: String?) -> CCItemModel
    func item(index: Int) -> CCItemModel
    func item(type: CCItemModel.Identifiers) -> CCItemModel
    
    // - Access to ViewModels
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in item: CCItemModel) -> M?
    func viewModelCell<M: CCViewModelCellProtocol>(index: Int, in item: CCItemModel) -> M?
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in type: CCItemModel.Identifiers) -> M?
    func viewModelHeader<M: CCViewModelSectionProtocol>(in item: CCItemModel) -> M?
    
    func updateHeightCell(id: String?, in item: CCItemModel, by value: Float)
    func updateHeightCell(id: String?, in type: CCItemModel.Identifiers, by value: Float)
    
    func countItems() -> Int
    func isEmpty(in item: CCItemModel) -> Bool
}

// MARK: - CCManagerContextProtocol
protocol CCManagerContextSettersProtocol {
    func set(viewDelegate: CCManagerContextViewCallbackProtocol?)
    func set(template: CCTemplateViewModels?)
    func set(items: [CCItemModel]?)
}

protocol CCManagerContextItemsProtocol {
    func append(item: CCItemModel)
    func intert(item: CCItemModel, at index: Int)
    func remove(item: CCItemModel, at index: Int)
}

protocol CCManagerContextProtocol: class, CCManagerContextSettersProtocol, CCManagerContextItemsProtocol {
    var items: [CCItemModel] { get set }
    
    func isEmpty() -> Bool
    
    func refreshAllItems()
    func reloadAllInAllItems(viewCallback type: CCManagerContextViewCallbackType)
    func refreshAllInAllItems()
    func refreshCellsInAllItems()
    func refreshSectionsInAllItems()
    
    func replaceCells(in item: CCItemModel, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType)
    func replaceCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], viewCallback type: CCManagerContextViewCallbackType)
    
    func appendCells(in item: CCItemModel, cells: [CCModelCellProtocol])
    func insertCells(in item: CCItemModel, cells:[CCModelCellProtocol], by position: Int)
    func insertCells(in typeId: CCItemModel.Identifiers, cells: [CCModelCellProtocol], by position: Int)
    
    func removeCells(in item: CCItemModel, by position: Int)
    func removeCells(in typeId: CCItemModel.Identifiers, by position: Int)
    
    func removeAllCells(in item: CCItemModel)
    func removeAllCells(in typeId: CCItemModel.Identifiers)
}
