//
//  TemplateViewModels.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public protocol TemplateViewModelsProtocol {
    
    // MARK: - Properties
    
    /// Определение ViewModel по Model для header секции
    var createHeader: ((_ model: ModelSectionProtocol?) -> ViewModelSectionProtocol?)? { get }
    
    /// Определение ViewModel по Model для footer секции
    var createFooter: ((_ model: ModelSectionProtocol?) -> ViewModelSectionProtocol?)? { get }
    
    /// Определение ViewModel по Model для ячейки
    var createCell: ((_ model: ModelCellProtocol?) -> ViewModelCellProtocol)? { get }
    
}
