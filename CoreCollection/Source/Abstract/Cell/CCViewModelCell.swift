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

protocol CCViewModelBehaviorsCell {
    func updateView()       //  Обновление полей view из model
    func updateModel()      //  Обновление полей model из view
}

class CCViewModelCell {
    private var view:   CCViewCellProtocol?
    private var model:  CCModelCellProtocol
    
    private var output: CCViewModelCellOutputProtocol?
    
    private var id: String?
    
    private var reusebleId: String?
    private var nibName:    String?
    
    //  MARK: Initialization
    
    init(model: CCModelCellProtocol, id: String?, reusebleId: String?, nibName: String?) {
        self.model = model
        self.id = id
        self.reusebleId = reusebleId
        self.nibName = nibName
    }
    
    convenience init(model: CCModelCellProtocol, id: String? = nil, reusebleId: String) {
        self.init(model: model, id: id, reusebleId: reusebleId, nibName: nil)
    }
    
    convenience init(model: CCModelCellProtocol, id: String? = nil, nibName: String) {
        self.init(model: model, id: id, reusebleId: nil, nibName: nibName)
    }
    
}
