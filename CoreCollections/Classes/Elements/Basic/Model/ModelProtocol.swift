//
//  ModelProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Базова сущность модели для ячеек и секций
public protocol ModelProtocol: AnyObject {
    
    /// Идентификатор модели
    var id: String? { get set }
    
    /// Item принадлежности коллекции
    var item: ItemModel? { get set }
    
    /// ViewModel ячейки или секции
    var viewModel: ViewModelProtocol? { get set }
    
}
