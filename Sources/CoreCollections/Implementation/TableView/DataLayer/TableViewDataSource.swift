//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

/// Реализация DataSource для коллекции таблицы
public final class TableViewDataSource: NSObject, DataSourceProtocol, UITableViewDataSource {
    
    // MARK: - Properties
    
    /// Chain data source
    public var chain: DataSourceProtocol?
    
    /// Контейнер данных для
    public var containerData: ContainerDataProtocol
    
    // MARK: - Init
    
    public init( _ chain: DataSourceProtocol?, containerData: ContainerDataProtocol) {
        self.chain = chain
        self.containerData = containerData
    }
    
    deinit {
        print("TableViewDataSource -> deinit")
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return chain?.containerData.items.count ?? containerData.items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chain?.containerData.items[section].cells.count ?? containerData.items[section].cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel =
                chain?.containerData.items[indexPath.section].cells[indexPath.row] ??
                containerData.items[indexPath.section].cells[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: viewModel.cellIdentifier,
            for: indexPath
        )
        
        viewModel.eraseTo(cell: cell)
        viewModel.injectTo(indexPath: indexPath)
        viewModel.view.prepareForData()
        
        return cell
    }
    
}
