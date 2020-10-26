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

// MARK: - UITableViewDataSource
class CCTableViewDataSource: CCDataSource, CCTableViewDataSourceProtocol, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? CCTableViewCell
            viewModel.inject(view: cell)
        case .reusebleName(let name):
            viewModel.inject(view: self.nibCell(nameNib: name) as? CCTableViewCell)
        }
        
        viewModel.initialViewFromNib()
        
        guard let viewCell = viewModel.getView as? UITableViewCell & CCViewCellProtocol else {
            fatalError("CCTableViewDataSource: view for ViewModel \(String(describing: type(of: viewModel))) not initialization!")
        }
        
        return viewCell
    }
}

extension CCTableViewDataSource {
    func nibCell<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(nameNib, owner: nil, options: nil)![0] as? T
    }
}
