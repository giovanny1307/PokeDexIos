//
//  BaseStaticTVC.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import UIKit

class Row {
    var cell: UITableViewCell!
}

class BaseStaticTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var tableView: UITableView!
    var dataSource: [Row] = []
    
    func hideFooter(){
        tableView.tableFooterView = UIView()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataSource[indexPath.row]
        row.cell.setNeedsLayout()
        return row.cell
    }
    
    @discardableResult
    func appendRow<T: UITableViewCell>(_:T.Type = T.self, cellSetup: ((T) -> Void)? = nil) -> T! {
        let name = String(describing: T.self)
        tableView.register(UINib(nibName: name, bundle: Bundle.main), forCellReuseIdentifier: name)
        let typedCell: T = tableView.getReusableCell()
        let row: Row = Row()
        row.cell = typedCell
        dataSource.append(row)
        cellSetup?(typedCell)
        return typedCell
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    

}
