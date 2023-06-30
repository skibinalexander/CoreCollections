//
//  SpacingSectionView.swift
//  CoreCollectionExample
//
//  Created by skibinalexander on 04.01.2023.
//

import CoreCollections
import UIKit

public final class SpacingSectionView: UIView, WrappedViewProtocol {
    
    // MARK: - WrappedViewProtocol
    
    public typealias ViewModel = TableViewModelSection<SpacingSectionView, Model>
    
    public var viewModel: TableViewModelSection<SpacingSectionView, Model>?
    
    public static func instanceView() -> Self {
        return SpacingSectionView(frame: .zero) as! Self
    }
    
    public func prepareForData() {
        
    }
    
    public func prepareForReuse() {
        
    }
    
    // MARK: - Properties
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        self.backgroundColor = .red
        self.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
}

extension SpacingSectionView {
    
    public struct Model: ModelProtocol {
        public var id: String
    }
    
}
