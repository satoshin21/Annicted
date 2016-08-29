//
//  MyProgramsViewModel.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import RxSwift
import RxCocoa
import APIKit
import Action
import KeychainAccess


class MyProgramsViewModel {
    
    let refreshTrigger = PublishSubject<Void>()
    
    var pageIndex = 1
    
    let myPrograms = Variable<[MyProgram]>([])
    
    let error = Variable<ErrorType?>(nil)
    
    let disposeBag = DisposeBag()
    
    let isLoading = Variable<Bool>(false)
    
    init () {
        
        refreshTrigger
            .filterHasAccessToken()
            .filter{!self.isLoading.value}
            .subscribeNext {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.pageIndex = 1
                weakSelf.isLoading.value = true
                Session.sharedSession.sendRequest(MyProgramsRequest(page:weakSelf.pageIndex), handler: { (result) in
                    self?.isLoading.value = false
                    result
                    switch result {
                    case .Success(let success):
                        self?.myPrograms.value = success.elements
                    case .Failure(let error):
                        self?.error.value = error
                    }
                })
        }.addDisposableTo(disposeBag)
        
        isLoading.asDriver()
            .drive(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
    }
}

extension Observable {
    func filterHasAccessToken() -> Observable {
        return self.filter{_ in Keychain()["accessToken"] != nil }
    }
}