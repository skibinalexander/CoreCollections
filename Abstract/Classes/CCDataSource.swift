//
//  CCDataSource.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCDataSource<T: CCTemplateViewModels> {
    
    //  MARK: Properties
    
    private var template: CCTemplateViewModels
    
    //  MARK: Lifecycle
    
    init(output: CCViewModelCellOutputProtocol?) {
        self.template = T(output: output)
    }
    
}

//  MARK: Imeplementation

extension CCDataSource {
    
    //  MARK: Cells
    
    public func cell(at indexPath: IndexPath) -> CCViewModelCell? {
        return nil
    }
    
    public func cell(at id: String) -> CCViewModelCell? {
        return nil
    }
    
    public func cell(at paths: [IndexPath]) -> [CCViewModelCell] {
        return []
    }
    
    public func cell(at ids: [String]) -> [CCViewModelCell] {
        return []
    }
    
    //  MARK: Reload
    
    public func reloadCell(at indexPath: IndexPath) {
        
    }
    
    public func reloadCell(at id: String) {
        
    }
    
    public func reloadCells(at paths: [IndexPath]) {
        
    }
    
    public func reloadCells(at ids: [String]) {
        
    }
    
    //  MARK:
    
    public func insertCell(at indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    public func insertCell(at id: String) -> IndexPath? {
        return nil
    }
    
    public func insertCells(at paths: [IndexPath]) -> [IndexPath] {
        return []
    }
    
    public func insertCells(at ids: [String]) -> [IndexPath] {
        return []
    }
    
    //  MARK: Append
    
    public func appendCell() -> IndexPath? {
        return nil
    }
    
    public func appendCells() -> [IndexPath] {
        return []
    }
    
    //  MARK: Remove
    
    public func removeCell(at indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    public func removeCell(at id: String) -> IndexPath? {
        return nil
    }
    
    public func removeCells(at paths: [IndexPath]) -> [IndexPath] {
        return []
    }
    
    public func removeCells(at ids: [String]) -> [IndexPath] {
        return []
    }
    
    //  MARK: Update
    
    public func updateViewCell(at indexPath: IndexPath) {
        
    }
    
    public func updateViewCell(at paths: [IndexPath]) {
        
    }
    
    public func updateViewCell(at id: String) {
        
    }
    
    public func updateViewCell(at ids: [String]) {
        
    }
    
    public func updateModelCell(at indexPath: IndexPath) {
        
    }
    
    public func updateModelCell(at paths: [IndexPath]) {
        
    }
    
    public func updateModelCell(at id: String) {
        
    }
    
    public func updateModelCell(at ids: [String]) {
        
    }
    
}


