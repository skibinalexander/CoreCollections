//
//  CCViewModel.swift
//  PaginationTableView
//
//  Created by Пользователь on 26/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

// MARK: - Constants

public enum CCViewModelCellViewSourceType {
    case reusebleId(String)     // - Reuse from registered identifier
    case reusebleName(String)   // - Reuse recreate from nib
}
public enum CCViewModelHeight {
    case automatic
    case value(Float)
}

// MARK: - Protocols

protocol CCViewProtocol: class {
    
    // MARK: - Static
    
    static var typeOf: String { get }
    
    // MARK: - Public Properties
    
    var viewModel: CCViewModelProtocol? { get set }
}

extension CCViewProtocol {
    static var typeOf: String { return String(describing: Self.self) }
}

protocol CCModelProtocol: class {
    var id: String? { get set }
    var item: CCItemModel? { get set }
    var viewModel: CCViewModelProtocol? { get set }
}

protocol CCViewModelProtocol: class {
    
    // MARK: - Public Properties
    
    /// Item view models таблицы
    var item: CCItemViewModel? { get set }
    
    /// Тип инициализации view
    var nibType: CCViewModelCellViewSourceType { get set }
    
    /// Заданная высота view
    var height: CCViewModelHeight { get set }
    
    /// Быстрый доступ к id модели
    var modelId: String? { get }
    
    var getModel: CCModelProtocol? { get }
    var getView: CCViewProtocol? { get }
    
    // MARK: - Inection
    
    func inject(model: CCModelProtocol?)
    func inject(view: CCViewProtocol?)
    
    func inject(with model: CCModelProtocol?) -> CCViewModelProtocol?
    func inject(with view: CCViewProtocol?) -> CCViewModelProtocol?
    
    func reference(item: CCItemViewModel?)
    
    // MARK: - Default Implementation
    
    func typealiasModel<T>() -> T?
    
    func initialViewFromNib()
    func updateViewFromModel()
    func updateModelFromView()
}

protocol CCViewModelInitialization: class {
    associatedtype Model: CCModelProtocol
    associatedtype View: CCViewProtocol
    
    var view: View! { get set }
    var model: Model! { get set }
}

class CCViewModel<V: CCViewProtocol, M: CCModelProtocol>: CCViewModelProtocol, CCViewModelInitialization {
    
    // MARK: - Typealias
    
    typealias View = V
    typealias Model = M
    
    // MARK: - Weak
    
    weak var view: V!
    weak var model: M!
    
    // MARK: - Public
    
    weak var item: CCItemViewModel?
    
    var nibType: CCViewModelCellViewSourceType
    var height: CCViewModelHeight
    
    var modelId: String? {
        getModel?.id
    }
    
    // MARK: - Getters Properties
    
    var getView: CCViewProtocol? {
        return view
    }
    
    var getModel: CCModelProtocol? {
        return model
    }
    
    // MARK: - Initialization
    init(nibType: CCViewModelCellViewSourceType = .reusebleName(V.typeOf), height: CCViewModelHeight = .automatic) {
        self.nibType = nibType
        self.height = height
    }
    
    // MARK: - Injections
    
    func inject(view: CCViewProtocol?) {
        self.view = view as? V
        self.view?.viewModel = self
    }
    
    func inject(model: CCModelProtocol?) {
        self.model = model as? M
        self.model?.viewModel = self
    }
    
    func inject(with model: CCModelProtocol?) -> CCViewModelProtocol? {
        self.inject(model: model)
        return self
    }
    
    func inject(with view: CCViewProtocol?) -> CCViewModelProtocol? {
        self.inject(view: view)
        return self
    }
    
    func reference(item: CCItemViewModel?) {
        self.item = item
    }
    
    // MARK: - Default Implementation
    
    /// Default typealias casting model for type
    func typealiasModel<T>() -> T? {
        model as? T
    }
    
    /// Default method for use instance view model
    func initialViewFromNib() { }
    
    /// Default method for use in updating view from model
    func updateViewFromModel() { }
    
    /// Default method for use in updating model from view
    func updateModelFromView() { }
    
}
