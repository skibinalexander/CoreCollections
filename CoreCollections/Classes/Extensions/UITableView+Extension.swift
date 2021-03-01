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
    func registerCell<T: TableViewCell>(_ coreCollectionCell: T.Type) {
        guard UINib.nib(withClass: coreCollectionCell) != nil else {
            fatalError("CoreCollection->UITableView+Extension: cell \(coreCollectionCell) nibLoad is nil!")
        }
        
        register(
            UINib(nibName: coreCollectionCell.typeOf, bundle: nil),
            forCellReuseIdentifier: coreCollectionCell.typeOf
        )
    }
    
    /// Регистрация TableViewCell
    func registerSection<U: TableViewSection>(_ coreCollectionSection: U.Type) {
        guard UINib.nib(withClass: coreCollectionSection) != nil else {
            fatalError("CoreCollection->UITableView+Extension: section \(coreCollectionSection) nibLoad is nil!")
        }

        register(
            UINib(nibName: coreCollectionSection.typeOf, bundle: nil),
            forCellReuseIdentifier: coreCollectionSection.typeOf
        )
    }
    
}
