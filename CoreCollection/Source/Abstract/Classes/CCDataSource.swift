//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCDataSourceProtocol {
    
    //  MARK: CellsDataSource
    
    func cell(at indexPath: IndexPath)              -> CCViewModelCell?
    func cell(at id: String)                        -> CCViewModelCell?
    func cell(at paths: [IndexPath])                -> [CCViewModelCell]
    func cell(at ids: [String])                     -> [CCViewModelCell]
    
    func reloadCell(at indexPath: IndexPath)
    func reloadCell(at id: String)
    func reloadCells(at paths: [IndexPath])
    func reloadCells(at ids: [String])
    
    func insertCell(at indexPath: IndexPath)        -> IndexPath?
    func insertCell(at id: String)                  -> IndexPath?
    func insertCells(at paths: [IndexPath])         -> [IndexPath]
    func insertCells(at ids: [String])              -> [IndexPath]
    
    func appendCell()                               -> IndexPath?
    func appendCells()                              -> [IndexPath]
    
    func removeCell(at indexPath: IndexPath)        -> IndexPath?
    func removeCell(at id: String)                  -> IndexPath?
    func removeCells(at paths: [IndexPath])         -> [IndexPath]
    func removeCells(at ids: [String])              -> [IndexPath]
    
    func updateViewCell(at indexPath: IndexPath)
    func updateViewCell(at paths: [IndexPath])
    func updateViewCell(at id: String)
    func updateViewCell(at ids: [String])
    
    func updateModelCell(at indexPath: IndexPath)
    func updateModelCell(at paths: [IndexPath])
    func updateModelCell(at id: String)
    func updateModelCell(at ids: [String])
    
}
