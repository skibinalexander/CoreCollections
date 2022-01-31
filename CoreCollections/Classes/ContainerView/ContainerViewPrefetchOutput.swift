//
//  ContainerViewPrefetchOutput.swift
//  Parcel
//
//  Created by Скибин Александр on 20.01.2021.
//  Copyright © 2021 Skibin Development. All rights reserved.
//

import Foundation

public protocol ContainerViewPrefetchOutputProtocol: AnyObject {
    
    /// Количество подгруженных ячеек
    /// - Parameter section: Номер секция коллекция
    func batchOfPaths(paths: [IndexPath])
    
}
