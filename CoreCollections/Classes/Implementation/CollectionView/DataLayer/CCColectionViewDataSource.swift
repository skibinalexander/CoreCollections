//
//  CCColectionViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCCollectionViewDataSource: DataSource, UICollectionViewDataSource {
    
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
        case .reusebleId(let id): cell.inject(view: collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? CCCollectionViewCell)
        case .reusebleName(let name): cell.inject(view: self.nibCell(nameNib: name) as? CCCollectionViewCell)
        }
        
        cell.initialViewFromNib()
        
        guard let viewCell = cell.getView as? UICollectionViewCell & ViewCellProtocol else {
            fatalError("CCCollectionViewDataSource: view for id ViewModel \(String(describing: type(of: cell))) not initialization!")
        }
        
        return viewCell
    }
    
}

extension CCCollectionViewDataSource {
    
    func nibCell<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? T
    }
    
}
