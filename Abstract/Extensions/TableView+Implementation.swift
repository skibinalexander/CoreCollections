//
//  TableView+Implementation.swift
//  Parcel
//
//  Created by Skibin Alexander on 03.07.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Регистрация ячейка по Id для UINib
    func registerReuseble(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
}
