//
//  String+OjectIdendetifable.swift
//  CoreCollections
//
//  Created by skibinalexander on 01.01.2023.
//

import Foundation

extension String {
    
    public var objIdentifiable: ObjectIdentifier {
        return .init(NSString(string: self))
    }
    
}
