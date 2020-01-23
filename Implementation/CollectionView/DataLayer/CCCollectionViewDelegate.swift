//
//  CCCollectionViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCCollectionViewDelegateOutputProtocol: CCDelegateOutputProtocol {
    
}

protocol CCCollectionViewDelegateProtocol: CCDelegateProtocol {
    
}

class CCCollectionViewDelegate: CCDelegate, CCCollectionViewDelegateProtocol, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    private weak var output: CCCollectionViewDelegateOutputProtocol?
    
    init(output: CCCollectionViewDelegateOutputProtocol?, template: CCTemplateViewModelsProtocol?) {
        self.output = output
        super.init(template: template)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            self.output?.didSelect(indexPath: indexPath, model: cell.getModel)
        }
    }
    
    func collectionView(_ CollectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            switch cell.height {
            case .value(let height): return CGFloat(height)
            default: return .zero
            }
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func collectionView(_ CollectionView: UICollectionView, viewForHeaderInSection section: Int) -> UIView? {
        if let viewModel = self.template?.viewModels[section].header {
            
            //  Иницализация view для секции
            
            switch viewModel.nibType {
            case .reusebleName(let name): viewModel.inject(view: self.nibSection(nameNib: name) as? CCViewProtocol)
            default: assertionFailure()
            }
            
            viewModel.updateView()
            
            return viewModel.getView as? UIView
        }
        
        return nil
    }
    
    func collectionView(_ CollectionView: UICollectionView, viewForFooterInSection section: Int) -> UIView? {
        if let viewModel = self.template?.viewModels[section].footer {
            
            //  Иницализация view для секции
            
            switch viewModel.nibType {
            case .reusebleName(let name): viewModel.inject(view: self.nibSection(nameNib: name) as? CCViewProtocol)
            default: assertionFailure()
            }
            
            viewModel.updateView()
            
            return viewModel.getView as? UIView
        }
        
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = self.template?.viewModels[section].header
        switch item?.height {
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
    
    func CollectionView(_ CollectionView: UICollectionView, heightForFooterInSection section: Int) -> CGFloat {
        let item = self.template?.viewModels[section].footer
        switch item?.height {
        case .value(let height)?: return CGFloat(height)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard indexPath.section < template?.viewModels.count ?? 0 else { return }
        if let item = template?.viewModels[indexPath.section].cells[indexPath.row]?.getView as? CCViewHighlightedCellProtocol {
            item.highlight()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard indexPath.section < template?.viewModels.count ?? 0 else { return }
        if let item = template?.viewModels[indexPath.section].cells[indexPath.row]?.getView as? CCViewHighlightedCellProtocol {
            item.unhiglight()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
            self.output?.willDisplay(indexPath: indexPath, model: cell.getModel)
        }
    }
    
}

extension CCCollectionViewDelegate {
    func nibSection<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? T
    }
}

