//
//  ListExampleTemplate.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import CoreCollections

class ListExampleTemplate: TemplateViewModelsProtocol {
    
    var createHeader: ((ModelSectionProtocol?) -> ViewModelSectionProtocol?)? {
        nil
    }
    
    var createFooter: ((ModelSectionProtocol?) -> ViewModelSectionProtocol?)? {
        nil
    }
    
    var createCell: ((ModelCellProtocol?) -> ViewModelCellProtocol)? {
        nil
    }
    
    static func newTemplate() -> TemplateViewModelsProtocol {
        ListExampleTemplate()
    }
    
}
