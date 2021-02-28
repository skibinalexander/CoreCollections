//
//  ContainerViewPrefetchOutput.swift
//  Parcel
//
//  Created by Скибин Александр on 20.01.2021.
//  Copyright © 2021 Skibin Development. All rights reserved.
//

import Foundation

public protocol ContainerViewPrefetchOutputProtocol: class {
    
    /// Подгузить новые данные при прокрутке
    func batchList()
    
    /// Количество подгруженных ячеек
    /// - Parameter section: Номер секция коллекция
    func batchNumberRows(in section: Int) -> Int
    
}
