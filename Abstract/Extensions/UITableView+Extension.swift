//
//  UITableView+Extension.swift
//  QRDynamic
//
//  Created by Aleksandr Khlebnikov on 27.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// Регистрация CCTableViewCell for reuseble Identifier
    func registerCell<T: CCTableViewCell>(_ coreCollectionCell: T.Type) {
        guard UINib.nib(withClass: coreCollectionCell) != nil else {
            fatalError("CoreCollection->UITableView+Extension: cell \(coreCollectionCell) nibLoad is nil!")
        }
        
        #if DEBUG
        print("CoreCollection->UITableView+Extension: register \(coreCollectionCell.typeOf)")
        #endif
        
        register(
            UINib(nibName: coreCollectionCell.typeOf, bundle: nil),
            forCellReuseIdentifier: coreCollectionCell.typeOf
        )
    }
    
    /// Регистрация CCTableViewCell
    func registerSection<U: CCTableViewSection>(_ coreCollectionSection: U.Type) {
        guard UINib.nib(withClass: coreCollectionSection) != nil else {
            fatalError("CoreCollection->UITableView+Extension: section \(coreCollectionSection) nibLoad is nil!")
        }

        #if DEBUG
        print("CoreCollection->UITableView+Extension: register \(coreCollectionSection.typeOf)")
        #endif

        register(
            UINib(nibName: coreCollectionSection.typeOf, bundle: nil),
            forCellReuseIdentifier: coreCollectionSection.typeOf
        )
    }
    
}
