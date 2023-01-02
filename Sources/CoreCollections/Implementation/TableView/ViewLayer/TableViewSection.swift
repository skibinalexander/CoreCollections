//
//  TableViewSection.swift
//  CoreCollections
//
//  Created by skibinalexander on 03.01.2023.
//

import UIKit

/// Базовая реализация View ячейки таблицы
open class TableViewSection<View: WrappedViewProtocol>: UITableViewHeaderFooterView {
    
    // MARK: - Private Implementation
    
    public var view: View!
    
    // MARK: - Init
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.view = View.instanceView()
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Implementation
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }
    
}
