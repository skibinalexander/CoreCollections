//
//  CCCollectionViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CollectionViewDelegate: Delegate, UICollectionViewDelegate {
    
    // MARK: - Private Properties
    
    private weak var output: DelegateOutputProtocol?
    
    // MARK: - Init
    
    init(output: DelegateOutputProtocol?) {
        self.output = output
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
//
//        } else {
//            assertionFailure("CCCollectionViewDelegate: undefined cell")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = self.mapper?.viewModels[indexPath.section].cells[indexPath.row] {
//
//        } else {
//            assertionFailure("CCCollectionViewDelegate: undefined cell")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard indexPath.section < mapper?.viewModels.count ?? 0 else { return }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard indexPath.section < mapper?.viewModels.count ?? 0 else { return }
    }
}

extension CollectionViewDelegate {
    func nibSection(nameNib: String) -> CCCollectionViewSection? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? CCCollectionViewSection
    }
}
