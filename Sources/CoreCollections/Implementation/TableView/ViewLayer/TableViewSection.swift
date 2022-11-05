//
//  CCTableViewSection.swift
//  PaginationTableView
//
//  Created by Пользователь on 25/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import UIKit

/// Базовая реализация View header или footer ячейки
open class TableViewSection: UIView, ViewSectionProtocol {
    public weak var viewModel: ViewModelProtocol?
}

// MARK: - Expanded ViewSection

/// Базовый функционал раскрывающейся секции
open class TableViewExpandedSection: TableViewSection {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var stateButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func actionStateButtonDidTouch(_ sender: UIButton) {
        if let viewModel = self.viewModel as? TableViewViewModelExpandedSection {
            viewModel.changeState()
        }
    }
    
}
