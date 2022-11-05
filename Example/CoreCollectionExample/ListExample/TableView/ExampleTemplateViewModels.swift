//
//  ExampleTemplateViewModels.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import CoreCollections

final class ExampleTemplateViewModels: TemplateViewModelsProtocol {
    
    var createHeader: ((ModelSectionProtocol?) -> ViewModelSectionProtocol?)? {
        nil
    }
    
    var createFooter: ((ModelSectionProtocol?) -> ViewModelSectionProtocol?)? {
        nil
    }
    
    var createCell: ((ModelCellProtocol?) -> ViewModelCellProtocol)? = {
        if $0 is ExampleViewModelCell.Model { return ExampleViewModelCell() }
        fatalError()
    }
    
}
