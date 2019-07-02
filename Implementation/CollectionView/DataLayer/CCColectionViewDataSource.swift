//
//  CCColectionViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCCollectionViewDataSource: CCDataSource, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.template?.viewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.template?.viewModels[section].cells.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] else {
            fatalError("Cell is Nil")
        }
        
        //  Иницализация view для ячейки
        
        switch cell.nibType {
        case .reusebleId:  cell.inject(view: collectionView.dequeueReusableCell(withReuseIdentifier: cell.nibId, for: indexPath) as? CCCollectionViewCell); break;
        case .nibName:     cell.inject(view: self.nibCell(nameNib: cell.nibId) as? CCCollectionViewCell); break;
        }
        
        guard let viewCell = cell.getView as? UICollectionViewCell & CCViewCellProtocol else {
            fatalError("CCTableViewDataSource: view for id ViewModel \(String(describing: type(of: cell))) not initialization!")
        }
        
        cell.updateView()
        
        return viewCell
        
    }
    
}

extension CCCollectionViewDataSource {
    
    func nibCell<T: UIView>(nameNib: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as! T
    }
    
}
