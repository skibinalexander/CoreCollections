//
//  ExampleSectionView.swift
//  CoreCollectionExample
//
//  Created by skibinalexander on 03.01.2023.
//

import UIKit
import CoreCollections

public final class ExampleSectionView: UITableViewHeaderFooterView, WrappedViewProtocol {
    
    // MARK: - WrappedViewProtocol
    
    public typealias ViewModel = TableViewModelSection<ExampleSectionView, Model>
    
    public var viewModel: TableViewModelSection<ExampleSectionView, Model>?
    
    public static func instanceView() -> Self {
        return ExampleSectionView(frame: .zero) as! Self
    }
    
    public func prepareForData() {
        label.text = viewModel?.model.text
    }
    
    public override func prepareForReuse() {
        label.text = nil
    }
    
    // MARK: - Properties
    
    public lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "initial txt"
        lbl.textColor = .white
        return lbl
    }()
    
    // MARK: - Lifecycle
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ExampleSectionView {
    
    public struct Model: ModelProtocol {
        
        public var id: String
        
        let text: String = "header of section"
        
    }
    
}

