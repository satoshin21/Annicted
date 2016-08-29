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
        
        let refreshControl = UIRefreshControl()
        refreshControl.rx_controlEvent(.ValueChanged).bindTo(viewModel.refreshTrigger).addDisposableTo(disposeBag)
        viewModel.isLoading.asDriver().drive(refreshControl.rx_refreshing).addDisposableTo(disposeBag)
        self.refreshControl = refreshControl
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel.myPrograms.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier("Cell"))(configureCell: { (index, myProgram, cell) in
            
            cell.textLabel?.text = myProgram.work.title
            
            }).addDisposableTo(disposeBag)
        
        viewModel.error.asObservable().filter({$0 != nil}).map({$0!}).subscribeNext {[weak self] (e) in
            let alert = UIAlertController(e: e)
            self?.presentViewController(alert, animated: true, completion: nil)
        }.addDisposableTo(disposeBag)
    }
}

	public protocol OptionalType {
    	    associatedtype Wrapped
    	    var value: Wrapped? { get }
    	}

	extension Optional: OptionalType {
	    /// Cast `Optional<Wrapped>` to `Wrapped?`
	    public var value: Wrapped? {
	        return self
	    }
	}

extension Observable where Element: OptionalType {
    
    func unwrap() {
        return
    }
}