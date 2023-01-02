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
            id: "test".objIdentifiable,
            header: TableViewModelSection<ExampleView, ExampleModel>(model: .init(id: "section")),
            cells: [
                TableViewModelCell<ExampleView, ExampleModel>(model: .init(id: "test"))
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.context.items.first?.cells.append(TableViewModelCell<ExampleView, ExampleModel>(model: .init(id: "test 1")))
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.context.items.first?.cells = []
//            self.context.items.first?.cells = [
//                TableViewModelCell<ExampleView, ExampleModel>(model: .init(id: "test 1")),
//                TableViewModelCell<ExampleView, ExampleModel>(model: .init(id: "test 2")),
//                TableViewModelCell<ExampleView, ExampleModel>(model: .init(id: "test 3"))
//            ]
        })
    }
    
}

extension String {
    
    var objIdentifiable: ObjectIdentifier {
        return .init(NSString(string: self))
    }
    
}
