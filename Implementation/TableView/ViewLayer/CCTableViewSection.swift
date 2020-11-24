//
//  CCTableViewSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

protocol CCTableViewSectionProtocol: UIView, CCViewSectionProtocol {}

public class CCTableViewSection: UIView, CCTableViewSectionProtocol {
    weak var viewModel: CCViewModelProtocol?
}

// MARK: - Expanded ViewSection

/// Базовый функционал раскрывающейся секции
class CCTableViewExpandedSection: CCTableViewSection {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var stateButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func actionStateButtonDidTouch(_ sender: UIButton) {
        if let viewModel = self.viewModel as? CCTableViewViewModelExpandedSectionProtocol {
            viewModel.changeState()
        }
    }
    
}
