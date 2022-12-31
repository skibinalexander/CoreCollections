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
    public var className: String { return String(describing: type(of: self)) }
    static public var className: String { return String(describing: self) }
}

public protocol NibLoadable { }

public extension NibLoadable where Self: UIView {
    
    static var nib: UINib {
        UINib(nibName: className, bundle: Bundle(for: self))
    }
    
    /// Загружаем вьюху из .xib файла и кастим к нужному типу
    static func instanceFromNib() -> Self {
        let results: [Any] = nib.instantiate(withOwner: self, options: nil)
        for result in results {
            if let view = result as? Self {
                return view
            }
        }
        fatalError("\(self) not found")
    }
}

#endif
