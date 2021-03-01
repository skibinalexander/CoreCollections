//
//  CCCollectionViewCell.swift
//  Vezu
//
//  Created by Пользователь on 02/07/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCCollectionViewCellProtocol: UICollectionViewCell, ViewCellProtocol {

}

class CCCollectionViewCell: UICollectionViewCell, CCCollectionViewCellProtocol {
    weak var viewModel: ViewModelProtocol?
}

extension CCCollectionViewCell {
    static var reusableName: String { return String(describing: self) }
}
