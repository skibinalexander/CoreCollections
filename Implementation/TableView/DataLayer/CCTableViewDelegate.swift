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

protocol CCTableViewDelegateProtocol: CCDelegateProtocol {
    
}

class CCTableViewDelegate: CCDelegate, CCTableViewDelegateProtocol, UITableViewDelegate {
    
    // MARK: - Properties

    private weak var output:    CCTableViewDelegateOutputProtocol?
    
    init(output: CCTableViewDelegateOutputProtocol?, template: CCTemplateViewModelsProtocol?) {
        self.output = output
        super.init(template: template)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            if let cell = cell.getView as? CCViewSelectedCellProtocol { cell.selected() }
            self.output?.didSelect(indexPath: indexPath, model: cell.getModel)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            if let cell = cell.getView as? CCViewSelectedCellProtocol { cell.deselected() }
            self.output?.didDeselect(indexPath: indexPath, model: cell.getModel)
        } else {
            assertionFailure("CCTableViewDelegate: undefined cell")
        }
    }
    
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
            case .singleName(let name): if viewModel.getView == nil { viewModel.inject(view: self.nibSection(nameNib: name)) }
            default: break
            }
            
            viewModel.updateView()
            
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
            
            viewModel.updateView()
            
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
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let item = template?.viewModels[indexPath.section].cells[indexPath.row]?.getView as? CCViewHighlightedCellProtocol {
            item.highlight()
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let item = template?.viewModels[indexPath.section].cells[indexPath.row]?.getView as? CCViewHighlightedCellProtocol {
            item.unhiglight()
        }
    }
    
}

extension CCTableViewDelegate {
    func nibSection(nameNib: String) -> CCTableViewSection? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? CCTableViewSection
    }
}
