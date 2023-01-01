//
//  ExampleView.swift
//  CoreCollectionExample
//
//  Created by skibinalexander on 31.12.2022.
//

import UIKit
import CoreCollections

public final class ExampleView: UIView, WrappedViewProtocol {
    
    // MARK: - WrappedViewProtocol
    
    public typealias ViewModel = TableViewModelCell<ExampleView, ExampleModel>
    
    public var viewModel: TableViewModelCell<ExampleView, ExampleModel>?
    
    public static func instanceView() -> Self {
        return ExampleView(frame: .zero) as! Self
    }
    
    public func prepareForData() {
        label.text = viewModel?.model.text
    }
    
    public func prepareForReuse() {
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
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
