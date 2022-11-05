//
//  ViewModelHeight.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Параметр определения высоты UI элемента ячейки или секции
public enum ViewModelHeight {
    
    /// Автоматическая высота элемнта
    case automatic
    
    /// Фиксированное значение высоты
    case value(Float)
    
}
