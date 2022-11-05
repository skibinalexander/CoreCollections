//
//  ViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

public protocol ViewModelCellProtocol: ViewModelProtocol {
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

open class ViewModelCell<V: ViewCellProtocol, M: ModelCellProtocol>:
    ViewModel<V, M>, ViewModelCellProtocol {
        
    public var indexPath: IndexPath!
    
    open func willDisplay() { }
    open func willSelect() {}
    open func didSelect() {}
    open func willDeselect() {}
    open func didDeselect() {}
    open func didHighlight() {}
    open func didUnhighlight() {}
    open func shouldHighlight() -> Bool { true }
    open func editingStyle() -> UITableViewCell.EditingStyle { .none }
    open func shouldIndentWhileEditing() -> Bool { false }
}
