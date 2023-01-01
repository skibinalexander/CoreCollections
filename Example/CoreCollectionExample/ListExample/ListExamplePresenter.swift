//
//  ListExamplePresenter.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import Combine
import CoreCollections

public struct ListExampleUseCase: ContainerDataProtocol {
    
    public var items: [ItemViewModel] = [
        .init(
            id: .init(NSString(string: "test")),
            cells: [
                TableViewModelCell<ExampleView, ExampleModel>(model: .init())
            ]
        )
    ]
    
}

final class ListExamplePresenter: TableViewPresenter {
    
    weak var view: ListExampleView!
    
    let publisher = PassthroughSubject<any CellViewModelProtocol, Never>()
    var subcriptions: [AnyCancellable] = []
    
    // MARK: - Initialization
    
    init(view: ListExampleView) {
        self.view = view
        super.init()
        
        self.containerView = view
        self.containerData = ListExampleUseCase()
        
        self.configuration()
        
        self.containerData.items.first?.cells.append(TableViewModelCell<ExampleView, ExampleModel>(model: .init()))
        self.containerData.items.first?.cells.append(TableViewModelCell<ExampleView, ExampleModel>(model: .init()))
        
        publisher.sink { cell in
            print(cell)
        }
        
        publisher.send(TableViewModelCell<ExampleView, ExampleModel>(model: .init()))
        
        self.containerView.reloadContainer()
    }
    
    override func refreshList() {
        self.containerView.reloadContainer()
    }
    
}
