//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewModelCellProtocol: CCViewModelProtocol {
    var indexPath: IndexPath? { get set }
}

class CCViewModelCell<V: CCViewCellProtocol, M: CCModelCellProtocol>: CCViewModel<V, M>, CCViewModelCellProtocol {
    var indexPath: IndexPath?
}
