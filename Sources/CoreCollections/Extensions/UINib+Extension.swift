//
//  UINib+Extension.swift
//  QRDynamic
//
//  Created by Aleksandr Khlebnikov on 28.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

#if !os(macOS)

import UIKit

extension NSObject {
    public var reuseIdentifier: String { type(of: self).reuseIdentifier }
    static public var reuseIdentifier: String { String(describing: self) }
}

#endif
