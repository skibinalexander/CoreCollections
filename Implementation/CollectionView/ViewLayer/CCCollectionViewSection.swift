//
//  CCCollectionViewSection.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

//  MARK: Base ViewSection

class CCCollectionViewSection: UIView, CCViewSectionProtocol {
    
    // MARK: - CCViewCellProtocol
    
    weak var viewModel: CCViewModelProtocol?
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
