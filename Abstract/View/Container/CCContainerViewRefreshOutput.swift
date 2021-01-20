//
//  CCContainerViewRefreshOutput.swift
//  Parcel
//
//  Created by Скибин Александр on 20.01.2021.
//  Copyright © 2021 Skibin Development. All rights reserved.
//

import Foundation

/// Output отожражения коллекции для обновления данных pullToRefresh
protocol CCContainerViewRefreshOutputProtocol: class {

    /// Сделать Refresh коллекции
    func refreshList()
    
}

extension CCContainerViewRefreshOutputProtocol {
    func refreshList() {}
}
