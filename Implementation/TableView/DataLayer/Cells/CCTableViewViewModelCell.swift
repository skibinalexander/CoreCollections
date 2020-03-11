//
//  CCTableViewViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - Base ViewModelCell
class CCTableViewViewModelCell<V: CCTableViewCellProtocol, M: CCTableViewModelCellProtocol>: CCViewModelCell<V, M> {
    convenience init(height: CCViewModelHeight) {
        self.init(nibType: .reusebleId(V.reusableName), height: height)
    }
}
