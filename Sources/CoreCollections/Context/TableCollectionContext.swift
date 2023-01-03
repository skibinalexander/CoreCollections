//
//  ManagerContext.swift
//  CoreCollections
//
//  Created by skibinalexander on 01.01.2023.
//

import Combine
import Foundation

public final class TableCollectionContext: ContainerDataProtocol {
    
    // MARK: - ContainerDataProtocol
    
    @Published public var items: [ItemViewModel]
    
    public weak var containerView: ContainerViewInputProtocol!
    public weak var delegateOutput: DelegateOutputProtocol?
    
    // MARK: - Properties
    
    public lazy var dataSource: TableViewDataSource = {
        TableViewDataSource(
            collectionView: containerView.resolveCollectionView(),
            containerData: self
        )
    }()
    
    public lazy var delegate: TableViewDelegate! = {
        TableViewDelegate(
            containerData: self,
            delegate: self.delegateOutput
        )
    }()
    
    // MARK: - Init
    
    public init(
        containerView: ContainerViewInputProtocol,
        items: [ItemViewModel],
        delegateOutput: DelegateOutputProtocol?
    ) {
        self.containerView = containerView
        self.items = items
        self.delegateOutput = delegateOutput
    }
    
    // MARK: - Configure
    
    public func configure(_ completion: (() -> Void)? = nil) {
        self.containerView.configure(dataSource: self.dataSource, delegate: self.delegate)
        self.reloadSnapshot(with: self.items)
    }
    
    // MARK: - Public Implementation
    
    public func find(item id: String) -> ItemViewModel? {
        return items.first(where: { $0.id == id })
    }
    
    public func reload() {
        self.reloadSnapshot(with: items)
    }
    
    // MARK: - Private Implementation
    
    private func reloadSnapshot(with items: [ItemViewModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(items.map { $0.id })
        
        for item in items {
            snapshot.appendItems(item.cells.map { .init(NSString(string: $0.model.id)) }, toSection: item.id)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func reloadSnapshot(in item: ItemViewModel) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: item.id))
        snapshot.appendItems(item.cells.map { .init(NSString(string: $0.model.id)) })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}
