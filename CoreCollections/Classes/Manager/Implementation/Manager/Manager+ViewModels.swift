//
//  Manager+ExecuteViewModels.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

public extension Manager {
    
    func viewModelCell<M>(id: String?) -> M? where M : ViewModelCellProtocol {
        let items = mapper.viewModels.filter({
            $0.cells.first(where: { cell in
                cell?.id == id
            }) != nil
        })
        
        return items.first?.cells.first(where: { $0?.id == id }) as? M
    }
    
    /// Метод быстрого получаения ViewModel ячейки по id ячейки и конкретному item в коллекции
    func viewModelCell<M: ViewModelCellProtocol>(id: String?, in item: ItemModel) -> M? {
        let cells = mapper.viewModels.first(where: { $0.id == item.id })?.cells
        return cells?.first(where: { $0?.getModel?.id == id }) as? M
    }

    /// Метод быстрого получаения ViewModel ячейки по индексу ячейки в конкретном item коллекции
    func viewModelCell<M: ViewModelCellProtocol>(index: Int, in item: ItemModel) -> M? {
        let cells = mapper.viewModels.first(where: { $0.id == item.id })?.cells
        return cells?[index] as? M
    }

    /// Метод быстрого получаения ViewModel ячейки по индексу ячейки в конкретном item коллекции найденному по готовому id коллекции
    func viewModelCell<M: ViewModelCellProtocol>(id: String?, in type: ItemModel.Identifiers) -> M? {
        if let item = containerData.items.first(where: { $0.id == type.rawValue }) {
            let cells = mapper.viewModels.first(where: { $0.id == item.id })?.cells
            return cells?.first(where: { $0?.getModel?.id == id }) as? M
        }
        
        return nil
    }

    /// Метод быстрого получаения ViewModel секуции в конкретном item коллекции
    func viewModelHeader<M: ViewModelSectionProtocol>(in item: ItemModel) -> M? {
        return mapper.viewModels.first(where: { $0.id == item.id })?.header as? M
    }
    
}
