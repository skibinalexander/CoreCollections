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

class CCTableViewCell: UITableViewCell, CCTableViewCellProtocol {
    weak var viewModel: CCViewModelProtocol?
    weak var output: CCViewModelCellOutputProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
