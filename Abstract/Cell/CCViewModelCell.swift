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
    
    //  MARK: Private
    
    var view:               CCViewCellProtocol?
    var model:              CCModelCellProtocol
    
    private var output:     CCViewModelCellOutputProtocol?
    
    //  MARK: Public
    
    var id:                 String?
    var reusebleId:         String?
    var nibName:            String?
    
    var sectionId:          String
    
    //  MARK: Initialization
    
    init(model: CCModelCellProtocol, sectionId: String, id: String?, reusebleId: String?, nibName: String?) {
        self.model = model
        self.sectionId = sectionId
        self.id = id
        self.reusebleId = reusebleId
        self.nibName = nibName
        
        self.model.viewModel = self
    }
    
    convenience init(model: CCModelCellProtocol, sectionId: String, id: String? = nil, reusebleId: String) {
        self.init(model: model, sectionId: sectionId, id: id, reusebleId: reusebleId, nibName: nil)
    }
    
    convenience init(model: CCModelCellProtocol, sectionId: String, id: String? = nil, nibName: String) {
        self.init(model: model, sectionId: sectionId, id: id, reusebleId: nil, nibName: nibName)
    }
    
    //  MARK: Setters
    
    func inject(view: CCViewCellProtocol?) {
        self.view = view
        view?.viewModel = self
    }
    
}

//  MARK: Public

extension CCViewModelCell {
    
    //  MARK: UpdateView
    
    public func updateView() {
        
    }
    
    //  MARK: UpdateModel
    
    func updateModel() {
        
    }
    
}
