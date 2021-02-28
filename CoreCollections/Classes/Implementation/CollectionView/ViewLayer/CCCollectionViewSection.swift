//
//  CCCollectionViewSection.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

// MARK: - Base ViewSection

class CCCollectionViewSection: UIView, ViewSectionProtocol {
    
    // MARK: - ViewCellProtocol
    
    weak var viewModel: ViewModelProtocol?
}

// MARK: - Expanded ViewSection

class CCCollectionViewExpandedSection: CCCollectionViewSection {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var stateButton: UIButton!
    
    // MARK: - Actions

    @IBAction func actionStateButtonDidTouch(_ sender: UIButton) {
        
        if let viewModel = self.viewModel as? CCCollectionViewViewModelExpandedSectionProtocol {
            viewModel.changeState()
        }
        
    }
    
}
