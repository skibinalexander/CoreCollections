//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDelegateOutputProtocol: class {
    func didSelect(indexPath: IndexPath, id: String?)
}

protocol CCTableViewDelegateProtocol: CCDelegateProtocol {
    
}

class CCTableViewDelegate: CCDelegate, CCTableViewDelegateProtocol, UITableViewDelegate {
    
    //  MARK: Properties

    private weak var output:    CCTableViewDelegateOutputProtocol?
    
    init(output: CCTableViewDelegateOutputProtocol?, template: CCTemplateViewModelsProtocol?) {
        self.output = output
        super.init(template: template)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            self.output?.didSelect(indexPath: indexPath, id: cell.modelId)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            switch cell.height {
            case .automatic: return UITableView.automaticDimension
            case .value(let height): return CGFloat(height)
            default: return .zero
            }
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let viewModel = self.template?.viewModels[section].header {
            
            //  Иницализация view для секции
            
            switch viewModel.nibType {
            default: viewModel.inject(view: self.nibSection(nameNib: viewModel.nibId) as? CCTableViewSection); break;
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
            default: viewModel.inject(view: self.nibSection(nameNib: viewModel.nibId) as? CCTableViewSection); break;
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
    
}

extension CCTableViewDelegate {
    
    func nibSection<T: UIView>(nameNib: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as! T
    }
    
}
