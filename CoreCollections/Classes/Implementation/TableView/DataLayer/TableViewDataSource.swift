//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

/// Реализация DataSource для коллекции таблицы
class TableViewDataSource: DataSource, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mapper?.viewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.mapper?.viewModels.count ?? 0 > section else {
            print("CCTableViewDataSource: numberOfRowsInSection -> count > section")
            return .zero
        }
        
        return self.mapper?.viewModels[section].cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] else { fatalError() }
        
        viewModel.indexPath = indexPath
        
        guard let viewIdentifier = viewModel.nibIdentifier else {
            assertionFailure()
            return .init()
        }
        
        //  Иницализация view для ячейки
        switch viewModel.nibType {
        case .reusebleId:
            viewModel
                .inject(view: tableView.dequeueReusableCell(withIdentifier: viewIdentifier, for: indexPath) as? TableViewCell)
        case .reusebleName:
            viewModel
                .inject(view: self.nibCell(nameNib: viewIdentifier) as? TableViewCell)
        }
        
        viewModel.initialViewFromNib()
        
        guard let viewCell = viewModel.getView as? UITableViewCell & ViewCellProtocol else {
            fatalError("CCTableViewDataSource: view for ViewModel \(String(describing: type(of: viewModel))) not initialization!")
        }
        
        return viewCell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        mapper?.moveRowAt(
            sourceIndexPath: sourceIndexPath,
            destinationIndexPath: destinationIndexPath
        )
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        canMoveAtRow
    }
    
}

extension TableViewDataSource {
    func nibCell<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(nameNib, owner: nil, options: nil)![0] as? T
    }
}
