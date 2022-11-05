//
//  ViewModelCellViewSourceType.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Параметр создания View элемента ячейки или секции
public enum ViewModelCellViewSourceType {
    
    /// Reuse from registered identifier
    case reusebleId
    
    /// Reuse recreate from nib
    case reusebleName
    
}
