//
//  UITableView+Extension.swift
//  QRDynamic
//
//  Created by Aleksandr Khlebnikov on 27.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// Регистрация CCTableViewCell
    /// Независимо от наличия xib
    func register<T: CCTableViewCell>(_ coreCollectionCell: T.Type) {
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
}
