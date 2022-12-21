//
//  ViewModelProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Базовая сущность вью-модели для ячеек и секций
public protocol ViewModelProtocol: AnyObject {
    
    // MARK: - Public Properties
    
    /// Быстрый доступ к id модели
    var id: String? { get }
    
    /// Item view models таблицы
    var item: ItemViewModel? { get set }
    
    /// Идентификатор для иницализации View
    var nibIdentifier: String? { get }
    
    /// Тип инициализации view
    var nibType: ViewModelCellViewSourceType { get set }
    
    /// Заданная высота view
    var height: ViewModelHeight { get set }
    
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