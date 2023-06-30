//
//  ExampleSectionView.swift
//  CoreCollectionExample
//
//  Created by skibinalexander on 03.01.2023.
//

import UIKit
import CoreCollections

public final class ExampleSectionView: UIView, WrappedViewProtocol {
    
    // MARK: - WrappedViewProtocol
    
    public typealias ViewModel = TableViewModelSection<ExampleSectionView, Model>
    
    public var viewModel: TableViewModelSection<ExampleSectionView, Model>?
    
    public static func instanceView() -> Self {
        return ExampleSectionView(frame: .zero) as! Self
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
        lbl.font = .systemFont(ofSize: 24)
        return lbl
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        self.backgroundColor = .red
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
    }
    
}

extension ExampleSectionView {
    
    public struct Model: ModelProtocol {
        
        public var id: String
        
        let text: String = "header of section"
        
    }
    
}

