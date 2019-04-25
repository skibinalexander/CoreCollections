//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

class CCTableViewDataSource<T: CCTemplateViewModels>: CCDataSource<T>, UITableViewDataSource {
    
    //  MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.template.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.template.cells.filter({ (cell) -> Bool in
            self.template.sections[section].id == cell.sectionId
        }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CCTableViewViewModelCell? = self.cell(at: indexPath)
        
        //  Иницализация view для ячейки
        
        if cell?.reusebleId != nil {
            cell?.inject(view: tableView.dequeueReusableCell(withIdentifier: cell!.reusebleId!, for: indexPath) as? CCTableViewCell)
        } else if cell?.nibName != nil {
            cell?.inject(view: self.nibCell(nameNib: cell!.nibName!) as? CCTableViewCell)
        }
        
        guard let viewCell = cell?.view as? UITableViewCell else {
            fatalError("CCTableViewDataSource: view for id ViewModel \(String(describing: cell?.id)) not initialization!")
        }
        
        return viewCell
    }
    
}

extension CCTableViewDataSource {
    
    func nibCell<T: UIView>(nameNib: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as! T
    }
    
}
