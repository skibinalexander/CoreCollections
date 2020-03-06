//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDataSourceProtocol: CCDataSourceProtocol {
    
}

class CCTableViewDataSource: CCDataSource, CCTableViewDataSourceProtocol, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.template?.viewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.template?.viewModels[section].cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] as? CCViewModelCellProtocol else { fatalError() }
        
        cell.indexPath = indexPath
        
        //  Иницализация view для ячейки
        switch cell.nibType {
        case .reusebleId(let id): cell.inject(view: tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? CCTableViewCell)
        case .reusebleName(let name): cell.inject(view: self.nibCell(nameNib: name) as? CCTableViewCell)
        case .singleName(let name): if cell.getView == nil { cell.inject(view: self.nibCell(nameNib: name) as? CCTableViewCell) }
        }
        
        guard let viewCell = cell.getView as? UITableViewCell & CCViewCellProtocol else {
            fatalError("CCTableViewDataSource: view for ViewModel \(String(describing: type(of: cell))) not initialization!")
        }
        
        return viewCell
    }
}

extension CCTableViewDataSource {
    func nibCell<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? T
    }
}
