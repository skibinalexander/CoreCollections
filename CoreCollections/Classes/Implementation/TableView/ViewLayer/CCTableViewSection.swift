//
//  CCTableViewSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

public protocol TableViewSectionProtocol: UIView, ViewSectionProtocol {}

public class CCTableViewSection: UIView, TableViewSectionProtocol {
    public weak var viewModel: ViewModelProtocol?
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
