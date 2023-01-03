//
//  TableViewModelCell.swift
//  CoreCollections
//
//  Created by skibinalexander on 01.01.2023.
//

import Foundation

open class TableViewModelCell<View: WrappedViewProtocol, Model: ModelProtocol>: CellViewModelProtocol {
    
    // MARK: - ViewModelProtocol
    
    public typealias View = View
    public typealias Model = Model
    
    public var reuseIdentifier:     String              { View.reuseIdentifier }
    public var indexPath:           IndexPath!
    public var height:              ViewModelHeight     { .automatic }
    
    public var shouldHighlight:     (() -> Bool)?
    public var didHighlight:        (() -> Void)?
    public var didUnhighlight:      (() -> Void)?
    
    public func eraseTo<Cell>(cell: Cell, at indexPath: IndexPath) {
        self.view = (cell as? TableViewCell<View>)?.view as? View
        self.view.viewModel = self as? View.ViewModel
    }
    
    public weak var view: View!
    public var model: Model!
    
    // MARK: - Init
    
    required public init(model: Model) {
        self.model = model
    }

}
