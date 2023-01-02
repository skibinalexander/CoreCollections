//
//  ListExamplePresenter.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import Combine
import CoreCollections

public struct ListExampleUseCase {
    
    public var items: [ItemViewModel] = [
        .init(
            id: "item_1".objIdentifiable,
            header: TableViewModelSection<ExampleSectionView, ExampleSectionView.Model>(model: .init(id: "section")),
            cells: [
                TableViewModelCell<ExampleCellView, ExampleCellView.Model>(model: .init(id: "cell"))
            ]
        ),
        .init(
            id: "item_2".objIdentifiable,
            cells: [
                TableViewModelCell<ExampleCellView, ExampleCellView.Model>(model: .init(id: "cell"))
            ]
        )
    ]
    
}

final class ListExamplePresenter: DelegateOutputProtocol {
    
    weak var view: ListExampleView!
    
    lazy var context: TableCollectionContext = {
        TableCollectionContext(
            containerView: view,
            items: ListExampleUseCase().items,
            delegateOutput: self
        )
    }()
    
    // MARK: - Initialization
    
    init(view: ListExampleView) {
        self.view = view
        self.context.configure()
    }
    
}

extension String {
    
    var objIdentifiable: ObjectIdentifier {
        return .init(NSString(string: self))
    }
    
}
