//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

public final class TableViewDelegate: NSObject, DelegateProtocol, UITableViewDelegate {
    
    // MARK: - Properties
    
    public var containerData: ContainerDataProtocol
    public weak var delegate: DelegateOutputProtocol?
    
    // MARK: - Init
    
    public init(
        containerData: ContainerDataProtocol,
        delegate: DelegateOutputProtocol? = nil
    ) {
        self.containerData = containerData
        self.delegate = delegate
    }
    
}

// MARK: - Heights Managment

extension TableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return updateHeight(for: containerData.items[indexPath.section].cells[indexPath.row].height)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = containerData.items[section].header else {
            return nil
        }
        
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: viewModel.reuseIdentifier
        ) else {
            return nil
        }
        
        viewModel.eraseTo(view: view, at: section)
        viewModel.view.prepareForData()
        
        return view
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let viewModel = containerData.items[section].footer else {
            return nil
        }
        
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: viewModel.reuseIdentifier
        ) else {
            return nil
        }
        
        viewModel.eraseTo(view: view, at: section)
        viewModel.view.prepareForData()
        
        return view
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
        let viewModel = containerData.items[indexPath.section].cells[indexPath.row]
        return viewModel.shouldHighlight?() ?? true
    }
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let viewModel = containerData.items[indexPath.section].cells[indexPath.row]
        viewModel.didHighlight?()
    }
    
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let viewModel = containerData.items[indexPath.section].cells[indexPath.row]
        viewModel.didUnhighlight?()
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let viewModel = containerData.items[indexPath.section].cells[indexPath.row]
        delegate?.willDisplay(viewModel: viewModel)
    }
    
}

extension TableViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollDidChange()
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndScrollingAnimation()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating()
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDecelerating()
    }
    
}
