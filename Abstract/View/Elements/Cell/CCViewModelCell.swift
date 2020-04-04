//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewModelCellProtocol: CCViewModelProtocol {
    func willSelect()
    func didSelect()
    func willDeselect()
    func didDeselect()
    func willDisplay()
    func didHighlight()
    func didUnHighlight()
    func shouldHighlight() -> Bool
}

class CCViewModelCell<V: CCViewCellProtocol, M: CCModelCellProtocol>: CCViewModel<V, M>, CCViewModelCellProtocol {
    func willDisplay() { }
    func willSelect() {}
    func didSelect() {}
    func willDeselect() {}
    func didDeselect() {}
    func didHighlight() {}
    func didUnHighlight() {}
    func shouldHighlight() -> Bool { return true }
}
