//
//  ListExamplePresenter.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import CoreCollections

final class ListExamplePresenter: TableViewPresenter {
    
    weak var view: ListExampleView!
    
    // MARK: - Initialization
    
    init(view: ListExampleView) {
        self.view = view
        super.init()
        
        ManagerBuilder<ExampleTemplateViewModels>()
            .configure(manager: self.manager)
            .configure(template: ExampleTemplateViewModels())
            .configure(containerView: self.view)
            .configure(viewDelegate: self)
            .configure(items: [.list()])
            .build()
        
        manager
            .getData()
            .replaceCells(
                in: .list,
                cells: [
                    ExampleModelCell(
                        label: "Тест москва -> питер",
                        id: "id"
                    )
                ],
                viewCallback: .reloadCollection
            )
        
    }
    
    // MARK: - TableView
    
    override func didSelect(viewModel: ViewModelCellProtocol) {
        super.didSelect(viewModel: viewModel)
        print(viewModel)
    }
    
}
