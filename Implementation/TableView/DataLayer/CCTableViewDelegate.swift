//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

protocol CCTableViewDelegateOutputProtocol: class {
    func didSelect(cell: CCTableViewViewModelCell, at indexPath: IndexPath, id: String?)
}

class CCTableViewDelegate: CCDelegate {
    
    //  MARK: Properties

    private weak var output: CCTableViewDelegateOutputProtocol?
    
    init(template: CCTemplateViewModels?, output: CCTableViewDelegateOutputProtocol?) {
        self.output = output
        super.init(template: template)
    }
    
}
