//
//  CCTableViewSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

//  MARK: Base ViewSection

class CCTableViewSection: UIView, CCViewSectionProtocol {
    
    //  MARK: CCViewCellProtocol
    
    weak var viewModel: CCViewModel?
}

//  MARK: Expanded ViewSection

class CCTableViewExpandedSection: CCTableViewSection {
    
    //  MARK: IBOutlets
    
    @IBOutlet weak var stateButton: UIButton!
    
    //  MARK: Actions
    
    @IBAction func actionStateButtonDidTouch(_ sender: UIButton) {
        
        if let viewModel = self.viewModel as? CCTableViewViewModelExpandedSection {
            viewModel.changeState()
        }
        
    }
    
}
