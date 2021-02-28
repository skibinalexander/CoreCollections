//
//  Delegate.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовый интерфейс для реализации евентов работы делегата данных коллекции
public protocol DelegateOutputProtocol: class {
    
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

/// Базовая реализация делегата коллекции
public class Delegate: NSObject {
    
    /// Шаблонизатор для выдачи ViewModel к маппингу Model в коллекции
    weak var template: TemplateViewModels!
    
    // MARK: - Initialization
    
    init(template: TemplateViewModels?) {
        self.template = template
        super.init()
    }
    
}
