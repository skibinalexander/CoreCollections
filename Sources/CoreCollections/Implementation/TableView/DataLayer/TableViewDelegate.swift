//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

public protocol TableViewDelegateProtocol: DelegateOutputProtocol {
    var editingStyle: UITableViewCell.EditingStyle { get set }
    var leadingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? { get set }
    var trailingSwipeConfig: ((IndexPath) -> UISwipeActionsConfiguration?)? { get set }
    var shouldIndentWhileEditingRowAt: Bool { get set }
}

class TableViewDelegate: Delegate, UITableViewDelegate {
    
    private weak var output: TableViewDelegateProtocol?
    
    // MARK: - Lifecycle
    
    init(output: TableViewDelegateProtocol?) {
        self.output = output
        super.init()
    }
    
}

// MARK: - Heights Managment

extension TableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            switch cell.height {
            case .automatic: return UITableView.automaticDimension
            case .value(let height): return CGFloat(height)
            }
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let viewModel = self.mapper?.viewModels[section].header, let id = viewModel.nibIdentifier {
            //  Иницализация view для секции
            switch viewModel.nibType {
            case .reusebleName: viewModel.inject(view: self.nibSection(nameNib: id))
            default: break
            }
            
            viewModel.initialViewFromNib()
            
            return viewModel.getView as? UIView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let viewModel = self.mapper?.viewModels[section].footer, let id = viewModel.nibIdentifier {
            //  Иницализация view для секции
            switch viewModel.nibType {
            case .reusebleName: viewModel.inject(view: self.nibSection(nameNib: id))
            default: break
            }
            
            viewModel.initialViewFromNib()
            
            return viewModel.getView as? UIView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard self.mapper.viewModels.count > section else {
            #if DEBUG
            print("CoreCollection: heightForHeaderInSection count < section")
            #endif
            return .zero
        }
        
        let item = self.mapper?.viewModels[section].header
        return updateHeight(for: item?.height)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard self.mapper.viewModels.count > section else {
            #if DEBUG
            print("CoreCollection: heightForHeaderInSection count < section")
            #endif
            return .zero
        }
        
        let item = self.mapper?.viewModels[section].footer
        return updateHeight(for: item?.height)
    }
    
    func updateHeight(for height: ViewModelHeight?) -> CGFloat {
        switch height {
        case .automatic?: return UITableView.automaticDimension
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
    
}

// MARK: - Selections

extension TableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.willSelect()
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.didSelect()
            self.output?.didSelect(viewModel: cell)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.willDeselect()
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.didDeselect()
            self.output?.didDeselect(viewModel: cell)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
    
}

// MARK: -

extension TableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            return cell.shouldHighlight()
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard indexPath.section < mapper?.viewModels.count ?? 0 else { return }
        
        // Highlight for ViewModels
        if let item = mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            item.didHighlight()
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard indexPath.section < mapper?.viewModels.count ?? 0 else { return }
        
        // UnHighlight for ViewModels
        if let item = mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            item.didUnhighlight()
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.willDisplay()
            self.output?.willDisplay(viewModel: cell)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
    
}

extension TableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        self.output?.editingStyle ?? .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        self.output?.shouldIndentWhileEditingRowAt ?? false
    }
    
}

extension TableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        output?.scrollDidChange()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        output?.scrollViewDidEndScrollingAnimation()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        output?.scrollViewDidEndDecelerating()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        output?.scrollViewWillBeginDecelerating()
    }
    
}

extension TableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        self.output?.leadingSwipeConfig?(indexPath) ?? nil
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        self.output?.trailingSwipeConfig?(indexPath) ?? nil
    }
    
}

// MARK: - Creation

extension TableViewDelegate {
    func nibSection(nameNib: String) -> TableViewSection? {
        return Bundle.main.loadNibNamed(
            String(describing: nameNib),
            owner: nil,
            options: nil
        )![0] as? TableViewSection
    }
}
