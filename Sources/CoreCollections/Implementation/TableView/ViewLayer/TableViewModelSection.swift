//
//  TableViewModelSection.swift
//  CoreCollections
//
//  Created by skibinalexander on 02.01.2023.
//

import Foundation

open class TableViewModelSection<View: WrappedViewProtocol, Model: ModelProtocol>: SectionViewModelProtocol {
    
    // MARK: - ViewModelProtocol
    
    public typealias View = View
    public typealias Model = Model
    
    public var reuseIdentifier:     String              { View.reuseIdentifier }
    public var indexPath:           IndexPath!
    public var height:              ViewModelHeight     { .automatic }
    
    public func eraseTo<Section>(view: Section, at index: Int) {
        self.view = view as? View
        self.view.viewModel = self as? View.ViewModel
    }
    
    public weak var view: View!
    public var model: Model!
    
    // MARK: - Init
    
    required public init(model: Model) {
        self.model = model
    }

}
