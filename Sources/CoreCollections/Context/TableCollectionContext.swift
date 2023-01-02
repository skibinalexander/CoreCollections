//
//  ManagerContext.swift
//  CoreCollections
//
//  Created by skibinalexander on 01.01.2023.
//

import Combine
import Foundation

public final class TableCollectionContext: ObservableObject, ContainerDataProtocol {
    
    // MARK: - ContainerDataProtocol
    
    @Published public var items: [ItemViewModel]
    
    public weak var containerView: ContainerViewInputProtocol!
    public weak var delegateOutput: DelegateOutputProtocol?
    
    // MARK: - Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    private var itemsDidChange: AnyPublisher<Void, Never> {
        self.objectWillChange
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
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
        self.subscribeItemsDidChange()
    }
    
    // MARK: - Configure
    
    public func configure(_ completion: (() -> Void)? = nil) {
        self.containerView.configure(dataSource: self.dataSource, delegate: self.delegate)
        self.reloadSnapshot(with: self.items)
    }
    
    // MARK: - Public Implementation
    
    public func reload() {
        self.reloadSnapshot(with: items)
    }
    
    // MARK: - Private Implementation
    
    private func subscribeItemsDidChange() {
        self.itemsDidChange
            .sink(receiveValue: { [weak self] _ in
                self?.reloadSnapshot(with: self?.items ?? [])
                return
            })
            .store(in: &cancellables)
    }
    
    private func subscribeCellsDidChange() {
        self.items.forEach { item in
            item.itemDidChange
                .sink(receiveValue: { [weak self] _ in
                    self?.reloadSnapshot(with: self?.items ?? [])
                    return
                })
                .store(in: &cancellables)
        }
    }
    
    private func reloadSnapshot(with items: [ItemViewModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(items.map { $0.id })
        
        for item in items {
            snapshot.appendItems(item.cells.map { .init(NSString(string: $0.model.id)) }, toSection: item.id)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false) {
            self.subscribeCellsDidChange()
        }
    }
    
    private func reloadSnapshot(in item: ItemViewModel) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: item.id))
        snapshot.appendItems(item.cells.map { .init(NSString(string: $0.model.id)) })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}
