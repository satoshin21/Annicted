//
//  MyProgramsViewController.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/16.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import RxSwift
import KeychainAccess

class MyProgramsViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var viewModel = MyProgramsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
    }
    
    func reloadData() {
        guard let _ = Keychain()["accessToken"] else {
            return
        }
        
        viewModel.requestMyPrograms().subscribe(onNext: { (json) in
            
            print(json.rawString()!)
            
            }, onError: {[weak self] (error) in
                let alert = UIAlertController(e: error)
                self?.presentViewController(alert, animated: true, completion: nil)
            }, onCompleted: { 
                
        }) { 
            
            }.addDisposableTo(disposeBag)
    }
}
