//
//  UITableView+Extension.swift
//  QRDynamic
//
//  Created by Aleksandr Khlebnikov on 27.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Регистрация CCTableViewCell
    func register(_ coreCollectionCell: CCTableViewCell.Type) {
        register(coreCollectionCell, forCellReuseIdentifier: coreCollectionCell.reusebleName)
    }
    
}
