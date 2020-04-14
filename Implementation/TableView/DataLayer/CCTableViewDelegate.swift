//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDelegateOutputProtocol: CCDelegateOutputProtocol {
    
}

class CCTableViewDelegate: CCDelegate, UITableViewDelegate {
    
    // MARK: - Properties
    private weak var output: CCTableViewDelegateOutputProtocol?
    
    // MARK: - Lifecycle
    init(output: CCTableViewDelegateOutputProtocol?, template: CCTemplateViewModelsProtocol?) {
        self.output = output
        super.init(template: template)
    }
    
}

// MARL: - Heights
extension CCTableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            switch cell.height {
            case .automatic: return UITableView.automaticDimension
            case .value(let height): return CGFloat(height)
            }
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let viewModel = self.template?.viewModels[section].header {
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
        if let viewModel = self.template?.viewModels[section].footer {
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
        let item = self.template?.viewModels[section].header
        switch item?.height {
        case .automatic?: return UITableView.automaticDimension
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let item = self.template?.viewModels[section].footer
        switch item?.height {
        case .automatic?: return UITableView.automaticDimension
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let item = self.template?.viewModels[section].header
        switch item?.height {
        case .automatic?: return UITableView.automaticDimension
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
}

// MARK: - Selections
extension CCTableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.willSelect()
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.didSelect()
            self.output?.didSelect(viewModel: cell)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.willDeselect()
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            cell.didDeselect()
            self.output?.didDeselect(viewModel: cell)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
}

// MARK: - Highlight
extension CCTableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            return cell.shouldHighlight()
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard indexPath.section < template?.viewModels.count ?? 0 else { return }
        
        // Highlight for ViewModels
        if let item = template?.viewModels[indexPath.section].cells[indexPath.row] {
            item.didHighlight()
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard indexPath.section < template?.viewModels.count ?? 0 else { return }
        
        // UnHighlight for ViewModels
        if let item = template?.viewModels[indexPath.section].cells[indexPath.row] {
            item.didUnHighlight()
        }
    }
}

// MARK: - Helpers
extension CCTableViewDelegate {
    func nibSection(nameNib: String) -> CCTableViewSection? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? CCTableViewSection
    }
}
