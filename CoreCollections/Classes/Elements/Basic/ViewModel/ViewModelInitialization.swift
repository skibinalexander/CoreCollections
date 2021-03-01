//
//  ViewModelInitialization.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

protocol ViewModelInitialization: class {
    associatedtype Model: ModelProtocol
    associatedtype View: ViewProtocol
    
    var view: View! { get set }
    var model: Model! { get set }
}
