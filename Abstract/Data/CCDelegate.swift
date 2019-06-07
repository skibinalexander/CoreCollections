//
//  CCDelegate.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCDelegateProtocol: class {
    
}

class CCDelegate: NSObject, CCDelegateProtocol {
    
    //  Properties
    
    weak var template: CCTemplateViewModelsProtocol?
    
    init(template: CCTemplateViewModelsProtocol?) {
        super.init()
        self.template = template
    }
    
}
