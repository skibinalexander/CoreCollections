//
//  ViewProtocol.swift
//  CoreCollections
//
//  Created by Скибин Александр on 01.03.2021.
//

import Foundation

public protocol WrappedViewProtocol: UIView, Identifiable {
    
    associatedtype ViewModel: ViewModelProtocol
    
    // MARK: - Public Properties
    
    var viewModel: ViewModel? { get set }
    
    // MARK: - Cell Implementation
    
    static func instanceView() -> Self
    
    /// Call when Cell prepare for display
    func prepareForData()
    
    /// Call when cell prepare for reuse
    func prepareForReuse()
    
}


//static func instanceView() -> Self {
//    Self.instanceFromNib()
//}
//
//private static var nib: UINib {
//    UINib(nibName: className, bundle: Bundle(for: self))
//}
//
///// Загружаем вьюху из .xib файла и кастим к нужному типу
//private static func instanceFromNib() -> Self {
//    let results: [Any] = nib.instantiate(withOwner: self, options: nil)
//    for result in results {
//        if let view = result as? Self {
//            return view
//        }
//    }
//    fatalError("\(self) not found")
//}
