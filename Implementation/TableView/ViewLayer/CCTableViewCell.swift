//
//  CCTableViewCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewCellProtocol: UITableViewCell, CCViewCellProtocol {
    
}

public class CCTableViewCell: UITableViewCell, CCTableViewCellProtocol {
    weak var viewModel: CCViewModelProtocol?
}

extension CCTableViewCell {
    static var reusebleName: String { return String(describing: self) }
}

