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
    func register(_ coreCollectionCell: CCTableViewCell.Type) {
        if UINib.nib(withClass: coreCollectionCell) != nil {
            register(
                UINib(nibName: coreCollectionCell.reusebleName, bundle: nil),
                forCellReuseIdentifier: coreCollectionCell.reusebleName
            )
        } else {
            register(coreCollectionCell, forCellReuseIdentifier: coreCollectionCell.reusebleName)
        }
    }
}
