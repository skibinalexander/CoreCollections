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
    
    ///
    var cellIdentifier: String { get}
    
    ///
    var view: View! { get }
    
    ///
    var model: Model! { get }
    
    ///
    var indexPath: IndexPath! { get }
    
    /// Заданная высота view
    var height: ViewModelHeight { get }
    
    // MARK: - Public Implemetation
    
    func eraseTo(cell: UITableViewCell)
    func injectTo(indexPath: IndexPath)
    
    // MARK: - Init
    
    init(model: Model)
    
}
