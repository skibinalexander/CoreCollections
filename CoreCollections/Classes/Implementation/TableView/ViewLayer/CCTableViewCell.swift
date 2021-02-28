//
//  TableViewCell.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

public protocol TableViewCellProtocol: UITableViewCell, ViewCellProtocol {}

public class TableViewCell: UITableViewCell, TableViewCellProtocol {
    public weak var viewModel: ViewModelProtocol?
}

