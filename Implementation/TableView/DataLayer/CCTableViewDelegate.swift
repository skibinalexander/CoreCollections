//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDelegateOutputProtocol: class {
    func didSelect(indexPath: IndexPath, id: String?)
}

protocol CCTableViewDelegateProtocol: class {
    
}

class CCTableViewDelegate: CCDelegate, CCTableViewDelegateProtocol, UITableViewDelegate {
    
    //  MARK: Properties

    private weak var output:            CCTableViewDelegateOutputProtocol?
    
    init(executor: (CCDataSourceExecuteItemsProtocol & CCDataSourceExecuteCellsProtocol)?,
         output: CCTableViewDelegateOutputProtocol?) {
        
        self.output = output
        super.init(executor: executor)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.executor?.cell(at: indexPath) {
            self.output?.didSelect(indexPath: indexPath, id: cell.modelId)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = self.executor?.cell(at: indexPath) {
            return CGFloat(cell.height)
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = self.executor?.item(at: section)
        
        //  Иницализация view для секции
        
        switch item?.header?.nibType {
        default: item?.header?.inject(view: self.nibSection(nameNib: item!.header!.nibId) as? CCTableViewSection); break;
        }
        
        item?.header?.updateView()
        
        return item?.header?.getView as? UIView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let item = self.executor?.item(at: section)
        
        //  Иницализация view для секции
        
        switch item?.footer?.nibType {
        default: item?.footer?.inject(view: self.nibSection(nameNib: item!.footer!.nibId) as? CCTableViewSection); break;
        }
        
        item?.footer?.updateView()
        
        return item?.footer?.getView as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = self.executor?.item(at: section)
        return CGFloat(item?.header?.height ?? .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let item = self.executor?.item(at: section)
        return CGFloat(item?.footer?.height ?? .zero)
    }
    
}

extension CCTableViewDelegate {
    
    func nibSection<T: UIView>(nameNib: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as! T
    }
    
}
