//
//  TemplateViewModelsDataSource.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

/// Базовый интерфейс реализации источника данных шаблона коллекции
///
/*
    Данный интерфейс описывает поведение коллекции при обращении стандартных
    DataSource (UITableView / UICollectionView)
 */
public protocol MapperViewModelsDataSource: AnyObject {
    
    /// Набор item коллекции
    var items: [ItemModel] { get set }
    
}
