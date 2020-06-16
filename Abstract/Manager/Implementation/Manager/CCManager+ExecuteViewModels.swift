//
//  CCManager+ExecuteViewModels.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

extension CCManager {
    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in item: CCItemModel) -> M? {
        let cells = template.viewModels.first(where: { $0.id == item.id })?.cells
        return cells?.first(where: { $0?.getModel?.id == id }) as? M
    }

    func viewModelCell<M: CCViewModelCellProtocol>(index: Int, in item: CCItemModel) -> M? {
        let cells = template.viewModels.first(where: { $0.id == item.id })?.cells
        return cells?[index] as? M
    }

    func viewModelCell<M: CCViewModelCellProtocol>(id: String?, in type: CCItemModel.Identifiers) -> M? {
        if let item = items.first(where: { $0.id == type.rawValue }) {
            let cells = template.viewModels.first(where: { $0.id == item.id })?.cells
            return cells?.first(where: { $0?.getModel?.id == id }) as? M
        }
        
        return nil
    }

    func viewModelHeader<M: CCViewModelSectionProtocol>(in item: CCItemModel) -> M? {
        return template.viewModels.first(where: { $0.id == item.id })?.header as? M
    }
}
