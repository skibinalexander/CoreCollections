//
//  ListExamplePresenter.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import CoreCollections

public struct ListExampleUseCase: ContainerDataProtocol {
    
    public var items: [ItemViewModel] = [
        .init(
            id: .init(NSString(string: "test")),
            cells: [
                ExampleViewModelCell(model: .init())
            ]
        )
    ]
    
}

final class ListExamplePresenter: TableViewPresenter {
    
    weak var view: ListExampleView!
    
    // MARK: - Initialization
    
    init(view: ListExampleView) {
        self.view = view
        super.init()
        
        self.containerView = view
        self.containerData = ListExampleUseCase()
        
        self.configuration()
        self.containerView.reloadContainer()
    }
    
    override func refreshList() {
        self.containerView.reloadContainer()
    }
    
}
