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
    
    required init(output: CCViewModelCellOutputProtocol?) {
        self.sections = []
        self.cells = []
    }
}
