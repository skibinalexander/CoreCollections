//
//  CCCollectionViewCell.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCCollectionViewCell: UICollectionViewCell, CCViewCellProtocol {
    weak var viewModel: CCViewModelProtocol?
    weak var output:    CCViewModelOutputProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewModel?.updateView()
    }
}
