//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol TableViewDelegateOutputProtocol: DelegateOutputProtocol {
    func scrollDidChange()
    func scrollViewDidEndScrollingAnimation()
}

class TableViewDelegate: Delegate, UITableViewDelegate {
    
    // MARK: - Properties
    
    private weak var output: TableViewDelegateOutputProtocol?
    
    // MARK: - Lifecycle
    
    init(output: TableViewDelegateOutputProtocol?) {
        super.init()
        self.output = output
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
        if let viewModel = self.mapper?.viewModels[section].header {
            //  Иницализация view для секции
            switch viewModel.nibType {
            case .reusebleName(let name): viewModel.inject(view: self.nibSection(nameNib: name))
            default: break
            }
            
            viewModel.initialViewFromNib()
            
            return viewModel.getView as? UIView
        }
        
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let viewModel = self.mapper?.viewModels[section].footer {
            //  Иницализация view для секции
            switch viewModel.nibType {
            case .reusebleName(let name): viewModel.inject(view: self.nibSection(nameNib: name))
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

//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        guard self.mapper.viewModels.count > section else {
//            #if DEBUG
//            print("CoreCollection: estimatedHeightForHeaderInSection count < section")
//            #endif
//            return .zero
//        }
//        
//        let item = self.mapper?.viewModels[section].header
//        return updateHeight(for: item?.height)
//    }
    
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
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension TableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        output?.scrollDidChange()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        output?.scrollViewDidEndScrollingAnimation()
    }
    
}

// MARK: - Creation

extension TableViewDelegate {
    func nibSection(nameNib: String) -> CCTableViewSection? {
        return Bundle.main.loadNibNamed(
            String(describing: nameNib),
            owner: nil,
            options: nil
        )![0] as? CCTableViewSection
    }
}