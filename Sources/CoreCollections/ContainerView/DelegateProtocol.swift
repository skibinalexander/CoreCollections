//
//  DelegateProtocol.swift
//  CoreCollections
//
//  Created by skibinalexander on 31.12.2022.
//

import Foundation

public protocol DelegateProtocol {
    
    /// Chain data source
    var chain: DelegateProtocol? { get set }
    
    /// Контейнер данных
    var containerData: ContainerDataProtocol { get set }
    
    /// Делегат обратных вызовов
    var delegate: DelegateOutputProtocol? { get set }
    
    // MARK: - Init
    
    init(_ chain: DelegateProtocol?, containerData: ContainerDataProtocol, delegate: DelegateOutputProtocol?)
    
}

public protocol DelegateOutputProtocol: AnyObject {
    func willDisplay(viewModel: any ViewModelProtocol)
    func willSelect(viewModel: any ViewModelProtocol)
    func didSelect(viewModel: any ViewModelProtocol)
    func willDeselect(viewModel: any ViewModelProtocol)
    func didDeselect(viewModel: any ViewModelProtocol)
    func scrollDidChange()
    func scrollViewDidEndScrollingAnimation()
    func scrollViewDidEndDecelerating()
    func scrollViewWillBeginDecelerating()
    func batchOfPaths(paths: [IndexPath])
}

public extension DelegateOutputProtocol {
    func willDisplay(viewModel: any ViewModelProtocol) {}
    func willSelect(viewModel: any ViewModelProtocol) {}
    func didSelect(viewModel: any ViewModelProtocol) {}
    func willDeselect(viewModel: any ViewModelProtocol) {}
    func didDeselect(viewModel: any ViewModelProtocol) {}
    func scrollDidChange() {}
    func scrollViewDidEndScrollingAnimation() {}
    func scrollViewDidEndDecelerating() {}
    func scrollViewWillBeginDecelerating() {}
    func batchOfPaths(paths: [IndexPath]) {}
}
