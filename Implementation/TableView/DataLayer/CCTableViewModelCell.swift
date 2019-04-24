//
//  CCTableViewModelCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewModelCell: UITableViewCell, CCModelCellProtocol {
    
    //  MARK: CCModelCellProtocol
    
    weak var viewModel: CCViewModelCell?
    
}
