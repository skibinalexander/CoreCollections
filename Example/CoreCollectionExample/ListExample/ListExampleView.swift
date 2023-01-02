//
//  ListExampleView.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 28.02.2021.
//

import CoreCollections
import UIKit

final class ListExampleView: TableViewController {
    
    var presenter: ListExamplePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(view: ExampleCellView.self, model: ExampleCellView.Model.self)
        tableView.registerSection(view: ExampleSectionView.self, model: ExampleSectionView.Model.self)
        presenter = ListExamplePresenter(view: self)
    }
    
}
