//
//  File.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

// MARK: - Base ViewModelCell
class CCCollectionViewViewModelCell<V: CCCollectionViewCellProtocol, M: CCCollectionViewModelCellProtocol>: CCViewModelCell<V, M> {
    convenience init(height: CCViewModelHeight) {
        self.init(nibType: .reusebleId(V.reusableName), height: height)
    }
}
