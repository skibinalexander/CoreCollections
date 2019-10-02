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
    case singleName(String)     // - Use once from nib
}
public enum CCViewModelHeight {
    case automatic
    case value(Float)
}

// MARK: - Protocols

protocol CCViewProtocol: class {
    var viewModel: CCViewModelProtocol? { get set }
}

protocol CCModelProtocol: class {
    var id: String? { get set }
    var item: CCItemModel? { get set }
    var viewModel: CCViewModelProtocol? { get set }
}

// MARK: -

protocol CCViewModelOutputProtocol: class {
    func modelDidChange(viewModel: CCViewModelProtocol)
}

protocol CCViewModelProtocol: class {
    static var typeOf: String { get }
    
    var output: CCViewModelOutputProtocol? { get set }
    var item: CCItemViewModel? { get set }
    
    var nibType: CCViewModelCellViewSourceType { get set }
    var height: CCViewModelHeight { get set }
    
    var getModel: CCModelProtocol? { get }
    var getView: CCViewProtocol? { get }
    
    // MARK: - Inection
    
    func inject(model: CCModelProtocol?)
    func inject(view: CCViewProtocol?)
    
    func inject(with model: CCModelProtocol?, output: CCViewModelOutputProtocol?) -> CCViewModelProtocol?
    func inject(with view: CCViewProtocol?) -> CCViewModelProtocol?
    
    func reference(item: CCItemViewModel?)
    
    // MARK: - Update
    func updateView()
    func updateModel()
}

extension CCViewModelProtocol {
    static var typeOf: String {
        return String(describing: type(of: self))
    }
}

protocol CCViewModelInitialization: class {
    associatedtype Model:   CCModelProtocol
    associatedtype View:    CCViewProtocol
    
    var view: View? { get set }
    var model: Model? { get set }
}

class CCViewModel<V: CCViewProtocol, M: CCModelProtocol>: CCViewModelProtocol, CCViewModelInitialization {
    
    typealias View = V
    typealias Model = M
    
    weak var view: V?
    weak var model: M?
    
    // MARK: - Public
    weak var output: CCViewModelOutputProtocol?
    weak var item: CCItemViewModel?
    
    var nibType: CCViewModelCellViewSourceType
    var height: CCViewModelHeight
    
    //  Getters Properties
    
    final var getView: CCViewProtocol? {
        return self.view
    }
    
    final var getModel: CCModelProtocol? {
        return self.model
    }
    
    // MARK: - Initialization
    
    init(nibType: CCViewModelCellViewSourceType, height: CCViewModelHeight) {
        self.nibType = nibType
        self.height = height
    }
    
    // MARK: - Injections
    
    func inject(view: CCViewProtocol?) {
//        assert(((model as? V) == nil), "func inject(view: CCViewProtocol?) no inject!")
        self.view = view as? V
        self.view?.viewModel = self
    }
    
    func inject(model: CCModelProtocol?) {
//        assert(((model as? M) == nil), "func inject(model: CCModelProtocol?) no inject!")
        self.model = model as? M
        self.model?.viewModel = self
    }
    
    func inject(with model: CCModelProtocol?, output: CCViewModelOutputProtocol?) -> CCViewModelProtocol? {
        self.inject(model: model)
        self.output = output
        return self
    }
    
    func inject(with view: CCViewProtocol?) -> CCViewModelProtocol? {
        self.inject(view: view)
        return self
    }
    
    func reference(item: CCItemViewModel?) {
        self.item = item
    }
    
    func updateView() { }
    func updateModel() { }
}
