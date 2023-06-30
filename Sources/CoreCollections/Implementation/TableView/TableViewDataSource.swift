//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

public final class TableViewDataSource: UITableViewDiffableDataSource<ObjectIdentifier, ObjectIdentifier>, DataSourceProtocol {

    public typealias CollectionView = UITableView
    
    /// Контейнер данных для
    public var containerData: ContainerDataProtocol
    
    // MARK: - Init
    
    public init(collectionView: UITableView, containerData: ContainerDataProtocol) {
        self.containerData = containerData
        
        super.init(tableView: collectionView, cellProvider: { (tableView, indexPath, id) in
            let viewModel = containerData.items[indexPath.section].cells[indexPath.row]
         
            let cell = tableView.dequeueReusableCell(
                withIdentifier: viewModel.reuseIdentifier,
                for: indexPath
            )
         
            viewModel.eraseTo(cell: cell, at: indexPath)
            viewModel.view.prepareForData()
         
            return cell
         })
    }
    
}
