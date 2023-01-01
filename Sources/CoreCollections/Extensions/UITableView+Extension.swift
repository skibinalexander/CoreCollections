//
//  UITableView+Extension.swift
//  QRDynamic
//
//  Created by Aleksandr Khlebnikov on 27.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// Регистрация TableViewCell for reuseble Identifier
    func registerCell<View: WrappedViewProtocol, Model: ModelProtocol>(view: View.Type, model: Model.Type) {
        self.register(
            TableViewCell<TableViewModelCell<View, Model>.View>.self,
            forCellReuseIdentifier: View.reuseIdentifier
        )
    }
//    
//    /// Регистрация TableViewCell
//    func registerSection<U: TableViewSection>(_ coreCollectionSection: U.Type) {
//        guard UINib.nib(withClass: coreCollectionSection) != nil else {
//            fatalError("CoreCollection->UITableView+Extension: section \(coreCollectionSection) nibLoad is nil!")
//        }
//
//        register(
//            UINib(nibName: coreCollectionSection.identifier, bundle: nil),
//            forCellReuseIdentifier: coreCollectionSection.identifier
//        )
//    }
    
}
