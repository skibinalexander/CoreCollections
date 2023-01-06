//
//  ViewProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import UIKit

public protocol WrappedViewProtocol: UIView, Identifiable {
    
    associatedtype ViewModel: ViewModelProtocol
    
    // MARK: - Public Properties
    
    var viewModel: ViewModel! { get set }
    
    // MARK: - Cell Implementation
    
    static func instanceView() -> Self
    
    /// Call when Cell prepare for display
    func prepareForData()
    
    /// Call when cell prepare for reuse
    func prepareForReuse()
    
}
