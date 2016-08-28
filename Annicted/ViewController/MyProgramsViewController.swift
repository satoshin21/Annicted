//
//  MyProgramsViewController.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/16.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KeychainAccess

class MyProgramsViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var viewModel = MyProgramsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx_sentMessage(#selector(UIViewController.viewWillAppear))
            .map{_ in}
            .bindTo(viewModel.refreshTrigger).addDisposableTo(disposeBag)
        
        if let refreshControl = refreshControl {
            refreshControl.rx_controlEvent(.ValueChanged).bindTo(viewModel.refreshTrigger).addDisposableTo(disposeBag)
        }
        
        viewModel.myPrograms.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier("CellIdentifier")) { _, riderName, cell -> Void in
            cell.textLabel?.text = riderName
            }.addDisposa
    }
}
