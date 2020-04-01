//
//  CCDelegate.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCDelegateOutputProtocol: class {
    // - Display
    func willDisplay(viewModel: CCViewModelProtocol)
    
    // - Selection
    func didSelect(viewModel: CCViewModelProtocol)
    func didDeselect(viewModel: CCViewModelProtocol)
    
}

extension CCDelegateOutputProtocol {
    func willDisplay(viewModel: CCViewModelProtocol) {}
    func didSelect(viewModel: CCViewModelProtocol) {}
    func didDeselect(viewModel: CCViewModelProtocol) {}
}

class CCDelegate: NSObject {
    // MARK: - Properties
    weak var template: CCTemplateViewModelsProtocol!
    
    // MARK: - Lifecycle
    init(template: CCTemplateViewModelsProtocol?) {
        self.template = template
        super.init()
    }
    
}
