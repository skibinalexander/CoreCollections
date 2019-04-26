//
//  CCViewModelCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewModelCellOutputProtocol: class {
    func viewDidChange()
    func modelDidChage()
}

class CCViewModelCell: CCViewModel {
    
    //  MARK: Public
    
    public var sectionId:       String
    
    //  MARK: Private
    
    private var output:     CCViewModelCellOutputProtocol?
    
    //  MARK: Lifecycle
    
    init(sectionId: String, output: CCViewModelCellOutputProtocol?, id: String?, nibId: String, nibType: CCViewModelCellViewSourceType, height: Float) {
        self.sectionId = sectionId
        self.output = output
        
        super.init(id: id, nibId: nibId, nibType: nibType, height: height)
    }
    
    required init(id: String?, nibId: String, nibType: CCViewModelCellViewSourceType, height: Float) {
        self.sectionId = ""
        super.init(id: id, nibId: nibId, nibType: nibType, height: height)
    }
    
}
