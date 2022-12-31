//
//  ExampleCell.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import UIKit
import CoreCollections

// MARK: - View Layer

public final class ExampleCell: TableViewCell<ExampleView> {}

// MARK: - ViewModel Layer

public final class ExampleViewModelCell: ViewModelProtocol {
    
    // MARK: - ViewModelProtocol
    
    public typealias View = ExampleView
    public typealias Model = ExampleModel
    
    public var cellIdentifier: String { ExampleCell.className }
    public var indexPath:  IndexPath!
    public var height:     ViewModelHeight { .automatic }
    
    public func eraseTo(cell: UITableViewCell) {
        self.view = (cell as? TableViewCell<View>)?.view as? View
        self.view.viewModel = self
    }
    
    public func injectTo(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    public weak var view: ExampleView!
    public var model: ExampleModel!
    
    // MARK: - Init
    
    public init(model: ExampleModel) {
        self.model = model
    }

}

// MARK: - Model Layer

public struct ExampleModel: ModelProtocol {
    
    let text: String = "text"
    
}
