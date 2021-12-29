//
//  DelegateScrollOutputProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 17.03.2021.
//

import Foundation

/// Базовый интерафейс для обработки евентов скрола
public protocol DelegateScrollOutputProtocol {
    
    /// Срабатывания евента скроллинга
    func scrollDidChange()
    
    /// Завершение аниации скроллинга
    func scrollViewDidEndScrollingAnimation()
    
    /// Called on finger up as we are moving
    func scrollViewWillBeginDecelerating()

    /// called when scroll view grinds to a halt
    func scrollViewDidEndDecelerating()
    
}
