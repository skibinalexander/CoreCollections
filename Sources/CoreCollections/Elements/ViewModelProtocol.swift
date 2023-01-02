//
//  ViewModelProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Базовая сущность вью-модели для ячеек и секций
public protocol ViewModelProtocol {
    
    associatedtype View: WrappedViewProtocol
    associatedtype Model: ModelProtocol
    
    // MARK: - Collection Properties
    
    /// Идентификатор для переиспользования UI
    var reuseIdentifier: String { get}
    
    /// Связанный UI
    var view: View! { get }
    
    /// Модель данных
    var model: Model! { get }
    
    /// Индекс
    var indexPath: IndexPath! { get }
    
    /// Заданная высота view
    var height: ViewModelHeight { get }
    
    // MARK: - Init
    
    init(model: Model)
    
}

public protocol CellViewModelProtocol: AnyObject, ViewModelProtocol {
    
    var shouldHighlight: (() -> Bool)? { get set }
    var didHighlight: (() -> Void)? { get set }
    var didUnhighlight: (() -> Void)? { get set }
    
    /// Восстановить связи модели ячейки и UI ячейки
    /// - Parameters:
    ///   - cell: UI ячейки
    ///   - indexPath: Позиция ячейки
    func eraseTo<Cell>(cell: Cell, at indexPath: IndexPath)
    
}

public protocol SectionViewModelProtocol: AnyObject, ViewModelProtocol {
    
    /// Восстановить связи модели ячейки и UI ячейки
    /// - Parameters:
    ///   - cell: UI ячейки
    ///   - indexPath: Позиция ячейки
    func eraseTo<Section>(view: Section, at index: Int)
    
}
