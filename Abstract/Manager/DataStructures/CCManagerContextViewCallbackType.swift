//
//  CCManagerContextViewCallbackType.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 16.06.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

enum CCManagerContextViewCallbackType {
    case withoutChangeView
    case reloadCollection
    case reloadInSection(Int)
    case insertIntoCollection
    case removeFromCollection
}
