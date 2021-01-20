//
//  CCContainerCollection.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

/// Интерфес View слоя для работы коллекции
protocol CCContainerViewInputProtocol: class {
    
    /// Конфигурация параметров данных и отображения
    /// - Parameters:
    ///   - dataSource: Источник данных коллекции
    ///   - delegate: Конфигуратор отображения коллекции
    func configure(dataSource: Any?, delegate: Any?)
    
    /// Конфигурация коллекции для пагинации
    /// - Parameter output: Обработчик подгрузки данных
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?)
    
    /// Конфигурация коллекции для pullToRefresh
    /// - Parameter output: Обработчик обновления данных
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?)
    
    /// Начать визуальное обновление коллекции
    func beginRefreshing()
    
    /// Закончить визуальное обновления коллекции
    func endRefreshing()
    
    /// Полная перезагрузка View слоя коллекции
    func reloadContainer()
    
    /// Вставка ячеек без перезагрузки всей коллекции
    /// - Parameter paths: Paths ячеек
    func insertCells(at paths: [IndexPath])
    
    /// Удаление ячеек без перезагрузки всей коллекции
    /// - Parameter paths: Paths ячеек
    func removeCells(at paths: [IndexPath])
    
    /// Перезагрузить список ячеек без перезагрузки всей коллекции
    /// - Parameter sections: Paths ячеек
    func reloadCells(in sections: [Int])
    
    /// Обновить высоту ячейки
    /// - Parameter completion: Completion завершения анимации
    func updateHieghtCell(completion: (() -> Void)?)
    
    /// Сообщение View слою о состоянии редактировании
    /// - Parameter editing: Включено ли редактирование коллекции
    func isEditing(_ editing: Bool)
}

extension CCContainerViewInputProtocol {
    func configurePagination(output: CCContainerViewPrefetchOutputProtocol?) {}
    func configureRefresh(output: CCContainerViewRefreshOutputProtocol?) {}
    
    func beginRefreshing() {}
    func endRefreshing() {}
    
    func insertCells(at paths: [IndexPath]) {}
    func removeCells(at paths: [IndexPath]) {}
    func reloadCells(in sections: [Int]) {}
    
    func updateHieghtCell(completion: (() -> Void)?) {}
}
