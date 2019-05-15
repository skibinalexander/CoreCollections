//
//  CCTableViewController.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewPresenterViewInputProtocol: class {
    func configure(dataSource: Any?, delegate: Any?)
    func configurePagination(output: CCTableViewPrefetchOutputProtocol?)
    func configureRefresh(output: CCTableViewRefreshOutputProtocol?)
    
    func becomeRefresing()
    func endRefresing()
    
    func reloadTableView()
    
    func insertCellsIntoTableView(at paths: [IndexPath])
    func removeCellsIntoTableView(at paths: [IndexPath])
    func reloadCellsIntoTableView(at paths: [IndexPath])
    
    func updateHieghtCell(completion: (()->Void)?)
}

protocol CCTableViewPrefetchOutputProtocol: class {
    func fetchList()
    func countList() -> Int
}

@objc
protocol CCTableViewRefreshOutputProtocol: class {
    func refreshList()
}

class CCTableViewController: UIViewController{
    
    //  MARK: IBOutlets
    
    @IBOutlet weak var tableView:   UITableView!
    private let refreshControl:     UIRefreshControl = UIRefreshControl()
    
    //  MARK: Properties
    
    private var prefetchOutput: CCTableViewPrefetchOutputProtocol?
    
}

//  MARK: Lifecycle

extension CCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//  MARK: CCTableViewPresenterViewInputProtocol

extension CCTableViewController: CCTableViewPresenterViewInputProtocol {

    func configure(dataSource: Any?, delegate: Any?) {
        let dataSource  = (dataSource as? UITableViewDataSource)
        let delegate    = (delegate as? UITableViewDelegate)
        
        guard dataSource != nil && delegate != nil else {
            assertionFailure("CCTableViewController: dataSourse \(String(describing: dataSource)) or delegate \(String(describing: delegate))")
            return
        }
        
        self.tableView.dataSource           = dataSource
        self.tableView.delegate             = delegate
    }
    
    func configurePagination(output: CCTableViewPrefetchOutputProtocol?) {
        if output != nil {
            self.tableView.prefetchDataSource = self
            self.prefetchOutput = output
        }
    }
    
    func configureRefresh(output: CCTableViewRefreshOutputProtocol?) {
        if output != nil {
            self.tableView.refreshControl = refreshControl
            self.refreshControl.addTarget(output!, action: #selector(CCTableViewRefreshOutputProtocol.refreshList), for: .valueChanged)
        }
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func insertCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.insertRows(at: paths, with: .automatic)
    }
    
    func removeCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.deleteRows(at: paths, with: .automatic)
    }
    
    func reloadCellsIntoTableView(at paths: [IndexPath]) {
        self.tableView.reloadRows(at: paths, with: .automatic)
    }
    
    func updateHieghtCell(completion: (()->Void)?) {
        if #available(iOS 11.0, *) {
            self.tableView.performBatchUpdates({
                completion?()
            }, completion: nil)
        } else {
            self.tableView.beginUpdates()
            completion?()
            self.tableView.endUpdates()
        }
    }
    
    func becomeRefresing() {
        self.refreshControl.beginRefreshing()
    }
    
    func endRefresing() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
}

//  MARK: UITableViewDataSourcePrefetching

extension CCTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let output = self.prefetchOutput else {
            return
        }
        
        if indexPaths.contains(where: { (indexPath) -> Bool in
            print(String(describing: indexPath.row) + "|" + String(describing: output.countList()))
            return indexPath.row >= (output.countList() - 1)
        }) {
            self.prefetchOutput?.fetchList()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
    
}
