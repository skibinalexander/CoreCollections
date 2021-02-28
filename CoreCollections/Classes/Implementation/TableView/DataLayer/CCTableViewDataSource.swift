//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

/// Реализация DataSource для коллекции таблицы
class CCTableViewDataSource: DataSource, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.template?.viewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.template?.viewModels.count ?? 0 > section else {
            print("CCTableViewDataSource: numberOfRowsInSection -> count > section")
            return .zero
        }
        
        return self.template?.viewModels[section].cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.template?.viewModels[indexPath.section].cells[indexPath.row] else { fatalError() }
        
        viewModel.indexPath = indexPath
        
        //  Иницализация view для ячейки
        switch viewModel.nibType {
        case .reusebleId(let id):
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? TableViewCell
            viewModel.inject(view: cell)
        case .reusebleName(let name):
            viewModel.inject(view: self.nibCell(nameNib: name) as? TableViewCell)
        }
        
        viewModel.initialViewFromNib()
        
        guard let viewCell = viewModel.getView as? UITableViewCell & ViewCellProtocol else {
            fatalError("CCTableViewDataSource: view for ViewModel \(String(describing: type(of: viewModel))) not initialization!")
        }
        
        return viewCell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        template?.moveRowAt(
            sourceIndexPath: sourceIndexPath,
            destinationIndexPath: destinationIndexPath
        )
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        canMoveAtRow
    }
    
}

extension CCTableViewDataSource {
    func nibCell<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(nameNib, owner: nil, options: nil)![0] as? T
    }
}
