//
//  ViewModel.swift
//  PaginationTableView
//
//  Created by Пользователь on 26/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

// MARK: - Constants

/// Параметр создания View элемента ячейки или секции
public enum ViewModelCellViewSourceType {
    
    /// Reuse from registered identifier
    case reusebleId(String)
    
    /// Reuse recreate from nib
    case reusebleName(String)
    
}

/// Параметр определения высоты UI элемента ячейки или секции
public enum ViewModelHeight {
    
    /// Автоматическая высота элемнта
    case automatic
    
    /// Фиксированное значение высоты
    case value(Float)
    
}

// MARK: - Protocols

public protocol ViewProtocol: class {
    
    // MARK: - Static
    
    /// Идентификатор создания UI
    static var typeOf: String { get }
    
    // MARK: - Public Properties
    
    /// ViewModel ячейки или секции
    var viewModel: ViewModelProtocol? { get set }
    
}

extension ViewProtocol {
    public static var typeOf: String { return String(describing: Self.self) }
}

/// Базова сущность модели для ячеек и секций
public protocol ModelProtocol: class {
    
    /// Идентификатор модели
    var id: String? { get set }
    
    /// Item принадлежности коллекции
    var item: ItemModel? { get set }
    
    /// ViewModel ячейки или секции
    var viewModel: ViewModelProtocol? { get set }
    
}

/// Базовая сущность вью-модели для ячеек и секций
public protocol ViewModelProtocol: class {
    
    // MARK: - Public Properties
    
    /// Item view models таблицы
    var item: ItemViewModel? { get set }
    
    /// Тип инициализации view
    var nibType: ViewModelCellViewSourceType { get set }
    
    /// Заданная высота view
    var height: ViewModelHeight { get set }
    
    /// Быстрый доступ к id модели
    var modelId: String? { get }
    
    var getModel: ModelProtocol? { get }
    var getView: ViewProtocol? { get }
    
    // MARK: - Inection
    
    func inject(model: ModelProtocol?)
    func inject(view: ViewProtocol?)
    
    func inject(with model: ModelProtocol?) -> ViewModelProtocol?
    func inject(with view: ViewProtocol?) -> ViewModelProtocol?
    
    func reference(item: ItemViewModel?)
    
    // MARK: - Default Implementation
    
    func typealiasModel<T>() -> T?
    
    func initialViewFromNib()
    func updateViewFromModel()
    func updateModelFromView()
}

protocol ViewModelInitialization: class {
    associatedtype Model: ModelProtocol
    associatedtype View: ViewProtocol
    
    var view: View! { get set }
    var model: Model! { get set }
}

public class ViewModel<V: ViewProtocol, M: ModelProtocol>:
    ViewModelProtocol, ViewModelInitialization {
    
    // MARK: - Typealias
    
    typealias View = V
    typealias Model = M
    
    // MARK: - Weak
    
    /// View слой
    weak var view: V!
    
    /// Model слой
    weak var model: M!
    
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
    init(nibType: ViewModelCellViewSourceType = .reusebleName(V.typeOf), height: ViewModelHeight = .automatic) {
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
    public func initialViewFromNib() { }
    
    /// Default method for use in updating view from model
    public func updateViewFromModel() { }
    
    /// Default method for use in updating model from view
    public func updateModelFromView() { }
    
}
