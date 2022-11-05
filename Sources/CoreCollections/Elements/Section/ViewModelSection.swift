//
//  ViewModelSection.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

/// Базовая вью-модель секции (header / footer)
public protocol ViewModelSectionProtocol: ViewModelProtocol {}

/// 
open class ViewModelSection<V: ViewSectionProtocol, M: ModelSectionProtocol>:
    ViewModel<V, M>, ViewModelSectionProtocol {}
