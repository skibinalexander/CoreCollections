//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDelegateOutputProtocol: class {
    func didSelect(cell: CCTableViewViewModelCell?, at indexPath: IndexPath, id: String?)
}

protocol CCTableViewDelegateProtocol: class {
    
}

class CCTableViewDelegate: CCDelegate, CCTableViewDelegateProtocol, UITableViewDelegate {
    
    //  MARK: Properties

    private weak var output: CCTableViewDelegateOutputProtocol?
    
    init(cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?, output: CCTableViewDelegateOutputProtocol?) {
        self.output = output
        super.init(cellsExecutor: cellsExecutor)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.cellsExecutor?.cell(at: indexPath) as? CCTableViewViewModelCell {
            self.output?.didSelect(cell: cell, at: indexPath, id: cell.id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = cellsExecutor?.cell(at: indexPath) {
            return CGFloat(cell.height)
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
}
