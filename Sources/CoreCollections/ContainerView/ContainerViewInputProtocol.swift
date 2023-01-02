//
//  ContainerCollection.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

/// Интерфес View слоя для работы коллекции
public protocol ContainerViewInputProtocol: AnyObject {
    
    /// Конфигурация параметров данных и отображения
    /// - Parameters:
    ///   - dataSource: Источник данных коллекции
    ///   - delegate: Конфигуратор отображения коллекции
    func configure(
        dataSource: UITableViewDataSource,
        delegate: UITableViewDelegate
    )
    
    /// Получить CollectionView
    func resolveCollectionView<V>() -> V
    
    /// Конфигурация коллекции для пагинации
    /// - Parameter output: Обработчик подгрузки данных
    func configure(output: ContainerViewOutputProtocol?)
    
    /// Начать визуальное обновление коллекции
    func beginRefreshing()
    
    /// Закончить визуальное обновления коллекции
    func endRefreshing()
    
    /// Обновить высоту ячейки
    /// - Parameter completion: Completion завершения анимации
    func updateHieghtCell(completion: (() -> Void)?)
    
    /// Сообщение View слою о состоянии редактировании
    /// - Parameter editing: Включено ли редактирование коллекции
    func isEditing(_ editing: Bool)
}

extension ContainerViewInputProtocol {
    public func beginRefreshing() {}
    public func endRefreshing() {}
    
    public func insertCells(at paths: [IndexPath]) {}
    public func removeCells(at paths: [IndexPath]) {}
    public func reloadCells(in sections: [Int]) {}
    
    public func updateHieghtCell(completion: (() -> Void)?) {}
}
