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

public class ViewModelCell<V: ViewCellProtocol, M: ModelCellProtocol>:
    ViewModel<V, M>, ViewModelCellProtocol {
        
    public var indexPath: IndexPath!
    
    public func willDisplay() { }
    public func willSelect() {}
    public func didSelect() {}
    public func willDeselect() {}
    public func didDeselect() {}
    public func didHighlight() {}
    public func didUnhighlight() {}
    public func shouldHighlight() -> Bool { true }
    public func editingStyle() -> UITableViewCell.EditingStyle { .none }
    public func shouldIndentWhileEditing() -> Bool { false }
}
