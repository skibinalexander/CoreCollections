//
//  ViewModel.swift
//  PaginationTableView
//
//  Created by Пользователь on 26/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

open class ViewModel<V: ViewProtocol, M: ModelProtocol>:
    ViewModelProtocol, ViewModelInitialization {
    
    // MARK: - Typealias
    
    public typealias View = V
    public typealias Model = M
    
    // MARK: - Weak
    
    /// View слой
    public weak var view: V!
    
    /// Model слой
    public weak var model: M!
    
    // MARK: - Public
    
    /// Item коллекции
    public weak var item: ItemViewModel?
    
    /// Тип View
    public var nibType: ViewModelCellViewSourceType
    
    /// Тип и значение высоты View
    public var height: ViewModelHeight
    
    /// Идентификатор параметра id модели
    public var modelId: String? {
        getModel?.id
    }
    
    // MARK: - Getters Properties
    
    public var getView: ViewProtocol? {
        return view
    }
    
    public var getModel: ModelProtocol? {
        return model
    }
    
    // MARK: - Initialization
    
    /// Базовый инициализатор для ViewModel
    /// - Parameters:
    ///   - nibType: Параметр типа View ячейки или секции
    ///   - height: Параметр высоты View ячейки или секции
    public init(
        nibType: ViewModelCellViewSourceType = .reusebleName(V.typeOf),
        height: ViewModelHeight = .automatic
    ) {
        self.nibType = nibType
        self.height = height
    }
    
    // MARK: - Injections
    
    public func inject(view: ViewProtocol?) {
        self.view = view as? V
        self.view?.viewModel = self
    }
    
    public func inject(model: ModelProtocol?) {
        self.model = model as? M
        self.model?.viewModel = self
    }
    
    public func inject(with model: ModelProtocol?) -> ViewModelProtocol? {
        self.inject(model: model)
        return self
    }
    
    public func inject(with view: ViewProtocol?) -> ViewModelProtocol? {
        self.inject(view: view)
        return self
    }
    
    public func reference(item: ItemViewModel?) {
        self.item = item
    }
    
    // MARK: - Default Implementation
    
    /// Default typealias casting model for type
    public func typealiasModel<T>() -> T? {
        model as? T
    }
    
    /// Default method for use instance view model
    open func initialViewFromNib() { }
    
    /// Default method for use in updating view from model
    open func updateViewFromModel() { }
    
    /// Default method for use in updating model from view
    open func updateModelFromView() { }
    
}
