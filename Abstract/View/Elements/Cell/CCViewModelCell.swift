//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

protocol CCViewModelCellProtocol: CCViewModelProtocol {
    var indexPath: IndexPath! { get set }
    
    func willSelect()
    func didSelect()
    func willDeselect()
    func didDeselect()
    func willDisplay()
    func didHighlight()
    func didUnhighlight()
    func shouldHighlight() -> Bool
    func editingStyle() -> UITableViewCell.EditingStyle
    func shouldIndentWhileEditing() -> Bool
}

class CCViewModelCell<V: CCViewCellProtocol, M: CCModelCellProtocol>: CCViewModel<V, M>, CCViewModelCellProtocol {
        
    var indexPath: IndexPath!
    
    func willDisplay() { }
    func willSelect() {}
    func didSelect() {}
    func willDeselect() {}
    func didDeselect() {}
    func didHighlight() {}
    func didUnhighlight() {}
    func shouldHighlight() -> Bool { true }
    func editingStyle() -> UITableViewCell.EditingStyle { .none }
    func shouldIndentWhileEditing() -> Bool { false }
}
