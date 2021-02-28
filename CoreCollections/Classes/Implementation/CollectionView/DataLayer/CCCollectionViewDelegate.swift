//
//  CCCollectionViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCCollectionViewDelegateOutputProtocol: DelegateOutputProtocol {
    
}

class CCCollectionViewDelegate: Delegate, UICollectionViewDelegate {
    
    // MARK: - Properties
    private weak var output: CCCollectionViewDelegateOutputProtocol?
    
    init(output: CCCollectionViewDelegateOutputProtocol?, template: TemplateViewModelsProtocol?) {
        self.output = output
        super.init(template: template)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
//
//        } else {
//            assertionFailure("CCCollectionViewDelegate: undefined cell")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] {
//
//        } else {
//            assertionFailure("CCCollectionViewDelegate: undefined cell")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard indexPath.section < template?.viewModels.count ?? 0 else { return }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard indexPath.section < template?.viewModels.count ?? 0 else { return }
    }
}

extension CCCollectionViewDelegate {
    func nibSection(nameNib: String) -> CCCollectionViewSection? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? CCCollectionViewSection
    }
}
