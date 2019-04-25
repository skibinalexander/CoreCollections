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

class CCTableViewDelegate: CCDelegate, UITableViewDelegate {
    
    //  MARK: Properties

    private weak var output: CCTableViewDelegateOutputProtocol?
    
    init(cellsExecutor: CCDataSourceExecuteCellsProtocol?, output: CCTableViewDelegateOutputProtocol?) {
        self.output = output
        super.init(cellsExecutor: cellsExecutor)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.cellsExecutor?.cell(at: indexPath) as? CCTableViewViewModelCell
        self.output?.didSelect(cell: cell, at: indexPath, id: cell?.id)
    }
    
}
