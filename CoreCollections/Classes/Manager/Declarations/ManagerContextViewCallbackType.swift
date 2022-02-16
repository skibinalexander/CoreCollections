//
//  ManagerContextViewCallbackType.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

/// Список типов обновления UI таблицы
///
/// Данный enum представляет список типов обновления UI viewModels
public enum ManagerContextViewCallbackType {
    
    /// Не обновлять UI
    case withoutChangeView
    
    /// Перезагрузить полностью UI
    case reloadCollection
    
    /// Перезагрузить секцию по индексу
    case reloadInSection(Int)
    
    /// Произвести вставку ячеек по indexPaths
    case insertIntoCollection
    
    /// Произвести удаление ячеек по  indexPaths
    case removeFromCollection
    
}
