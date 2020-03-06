//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewHighlightedCellProtocol {
    func highlight()
    func unhiglight()
}

protocol CCViewSelectedCellProtocol {
    func selected()
    func deselected()
}

protocol CCViewModelCellProtocol: CCViewModelProtocol {
    // MARK: - Properties
    var indexPath: IndexPath? { get set }
}

class CCViewModelCell<V: CCViewCellProtocol, M: CCModelCellProtocol>: CCViewModel<V, M>, CCViewModelCellProtocol {
    // MARK: - Properties
    var indexPath: IndexPath?
}

extension CCViewModelCell: CCViewSelectedCellProtocol, CCViewHighlightedCellProtocol {
    func selected() { }
    func deselected() { }
    func highlight() { }
    func unhiglight() { }
}
