//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

public final class TableViewDelegate: NSObject, DelegateProtocol, UITableViewDelegate {
    
    public var chain: DelegateProtocol?
    public var containerData: ContainerDataProtocol
    public weak var delegate: DelegateOutputProtocol?
    
    // MARK: - Init
    
    public init(
        _ chain: DelegateProtocol?,
        containerData: ContainerDataProtocol,
        delegate: DelegateOutputProtocol?
    ) {
        self.chain = chain
        self.containerData = containerData
        self.delegate = delegate
    }
    
    deinit {
        print("TableViewDelegate -> deinit")
    }
    
}

// MARK: - Heights Managment

extension TableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return updateHeight(for: containerData.items[indexPath.section].cells[indexPath.row].height)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return updateHeight(for: containerData.items[section].header?.height)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return updateHeight(for: containerData.items[section].footer?.height)
    }
    
    private func updateHeight(for height: ViewModelHeight?) -> CGFloat {
        switch height {
        case .automatic?: return UITableView.automaticDimension
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
    
}

// MARK: - Selections

extension TableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate?.willSelect(viewModel: self.containerData.items[indexPath.section].cells[indexPath.row])
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(viewModel: self.containerData.items[indexPath.section].cells[indexPath.row])
    }
    
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate?.willDeselect(viewModel: self.containerData.items[indexPath.section].cells[indexPath.row])
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate?.didDeselect(viewModel: self.containerData.items[indexPath.section].cells[indexPath.row])
    }
    
}

// MARK: -

extension TableViewDelegate {
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}

extension TableViewDelegate {
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }

    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
}

extension TableViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
}

extension TableViewDelegate {
    
    public func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    public func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        return nil
    }
    
}
