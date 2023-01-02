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
    
    /// Регистрация TableViewCell for reuseble Identifier
    func registerSection<View: WrappedViewProtocol, Model: ModelProtocol>(view: View.Type, model: Model.Type) {
        self.register(
            View.self,
            forHeaderFooterViewReuseIdentifier: View.reuseIdentifier
        )
    }
    
}
