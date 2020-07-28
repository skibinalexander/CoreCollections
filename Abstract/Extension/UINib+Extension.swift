//
//  UINib+Extension.swift
//  QRDynamic
//
//  Created by Aleksandr Khlebnikov on 28.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

public extension UINib {

    /// Согласно документации, так должен работать оригинальный метод nibWithNibName:bundle
    /// Однако, он возвращает некоторую сущность, несмотря на отсутствие в bundle nib с указанным именем.
    /// Пришлось реализовать обертку.
    class func nib(withClass className: AnyClass) -> UINib? {
        let bundle = Bundle(for: className)
        let name = String(describing: className)
        guard bundle.path(forResource: name, ofType: "nib") != nil else { return nil }
        return UINib(nibName: name, bundle: bundle)
    }

}
