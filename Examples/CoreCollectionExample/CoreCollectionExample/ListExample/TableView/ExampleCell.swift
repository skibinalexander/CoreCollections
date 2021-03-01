//
//  ExampleCell.swift
//  CoreCollectionExample
//
//  Created by Скибин Александр on 01.03.2021.
//

import UIKit
import CoreCollections

// MARK: - View Layer

class ExampleCell: TableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}

// MARK: - ViewModel Layer

class ExampleViewModelCell: TableViewViewModelCell<ExampleCell, ExampleModelCell> {
    
    convenience init() {
        self.init(nibType: .reusebleId(ExampleCell.typeOf), height: .value(44))
    }
    
    override func initialViewFromNib() {
        view.label.text = model.label
    }

}

// MARK: - Model Layer

class ExampleModelCell: TableViewModelCell {
    
    let label: String
    
    init(label: String, id: String?) {
        self.label = label
        super.init(id: id)
    }
    
}
