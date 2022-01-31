//
//  DelegateOutputProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 17.03.2021.
//

import Foundation

/// Базовый интерфейс для реализации евентов работы делегата данных коллекции
public protocol DelegateOutputProtocol:
    AnyObject,
    DelegateScrollOutputProtocol {
    
    /// Будет показана ячейка в коллекции
    /// - Parameter viewModel: ViewModel ячейки
    func willDisplay(viewModel: ViewModelCellProtocol)
    
    /// Выбрана ячейка в коллекции
    /// - Parameter viewModel: ViewModel ячейки
    func didSelect(viewModel: ViewModelCellProtocol)
    
    /// Не выбрана ячейка в коллекции
    /// - Parameter viewModel: ViewModel ячейки
    func didDeselect(viewModel: ViewModelCellProtocol)
    
}
