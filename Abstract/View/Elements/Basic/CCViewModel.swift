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
    var item: CCItemViewModel? { get set }
    
    var indexPath: IndexPath? { get set }
    
    var nibType: CCViewModelCellViewSourceType { get set }
    var height: CCViewModelHeight { get set }
    
    var getModel: CCModelProtocol { get }
    var getView: CCViewProtocol { get }
    
    // MARK: - Inection
    func inject(model: CCModelProtocol?)
    func inject(view: CCViewProtocol?)
    
    func inject(with model: CCModelProtocol?) -> CCViewModelProtocol?
    func inject(with view: CCViewProtocol?) -> CCViewModelProtocol?
    
    func reference(item: CCItemViewModel?)
    
    // MARK: - Implementation
    func initialViewFromNib()
    func updateViewFromModel()
    func updateModelFromView()
}

extension CCViewModelProtocol {
//    func initialViewFromNib() {}
    func updateViewFromModel() {}
    func updateModelFromView() {}
}

protocol CCViewModelInitialization: class {
    associatedtype Model: CCModelProtocol
    associatedtype View: CCViewProtocol
    
    var view: View! { get set }
    var model: Model! { get set }
}

class CCViewModel<V: CCViewProtocol, M: CCModelProtocol>: CCViewModelProtocol, CCViewModelInitialization {
    typealias View = V
    typealias Model = M
    
    weak var view: V!
    weak var model: M!
    
    // MARK: - Public
    weak var item: CCItemViewModel?

    var indexPath: IndexPath?
    
    var nibType: CCViewModelCellViewSourceType
    var height: CCViewModelHeight
    
    //  Getters Properties
    
    final var getView: CCViewProtocol { return self.view }
    final var getModel: CCModelProtocol { return self.model }
    
    // MARK: - Initialization
    
    init(nibType: CCViewModelCellViewSourceType = .reusebleName(V.typeOf), height: CCViewModelHeight) {
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
    
    // MARK: -
    func initialViewFromNib() { }
}
