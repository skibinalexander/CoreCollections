//
//  Delegate.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовая реализация делегата коллекции
public class Delegate: NSObject {
    
    /// Шаблонизатор для выдачи ViewModel к маппингу Model в коллекции
    public weak var mapper: MapperViewModels!
    
}
