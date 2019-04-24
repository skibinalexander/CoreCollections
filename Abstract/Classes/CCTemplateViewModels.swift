//
//  CCTemplateViewModels.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

class CCTemplateViewModels {
    private var sections:   [CCViewModelCell & CCViewModelBehaviorsCell]
    private var cells:      [CCViewModelCell & CCViewModelBehaviorsCell]
    
    private weak var output: CCViewModelCellOutputProtocol?
    
    required init(output: CCViewModelCellOutputProtocol?) {
        self.output = output
        self.sections = []
        self.cells = []
    }
}
