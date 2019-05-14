//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDelegateOutputProtocol: class {
    func didSelect(cell: CCTableViewViewModelCell?, at indexPath: IndexPath, id: String?)
}

protocol CCTableViewDelegateProtocol: class {
    
}

class CCTableViewDelegate: CCDelegate, CCTableViewDelegateProtocol, UITableViewDelegate {
    
    //  MARK: Properties

    private weak var output: CCTableViewDelegateOutputProtocol?
    
    init(sectionsExecutor: CCDataSourceExecuteViewModelsSectionsProtocol?, cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?, output: CCTableViewDelegateOutputProtocol?) {
        self.output = output
        super.init(sectionsExecutor: sectionsExecutor, cellsExecutor: cellsExecutor)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.cellsExecutor?.cell(at: indexPath) as? CCTableViewViewModelCell {
            self.output?.didSelect(cell: cell, at: indexPath, id: cell.id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = cellsExecutor?.cell(at: indexPath) {
            return CGFloat(cell.height)
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionViewModel: CCTableViewViewModelSection? = self.sectionsExecutor?.section(at: section)
        
        switch sectionViewModel?.nibType {
        case .nibName?:     sectionViewModel?.inject(view: self.nibSection(nameNib: sectionViewModel!.nibId) as? CCViewProtocol); break;
        default:break;
        }
        
        guard let viewSection = sectionViewModel?.view as? UIView else {
            fatalError("CCTableViewDataSource: view for id ViewModel \(String(describing: type(of: sectionViewModel?.view))) not initialization!")
        }
        
        sectionViewModel?.updateView()
        
        return viewSection
    }
    
}

extension CCTableViewDelegate {
    
    func nibSection<T: UIView>(nameNib: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as! T
    }
    
}
