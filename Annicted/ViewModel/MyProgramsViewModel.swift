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
//    let session = Session.sharedSession
    
    let refreshTrigger = PublishSubject<Void>()
    
//    let loadNextPageTrigger = PublishSubject<Void>()
    
    let myPrograms = Variable<[MyProgram]>([])
    
    let error = Variable<ErrorType?>(nil)
    
    let disposeBag = DisposeBag()
    
    let isLoading = Variable<Bool>(false)
    
    init () {
        
        refreshTrigger
            .filterHasAccessToken()
            .filter{!self.isLoading.value}
            .subscribeNext {[weak self] in
                self?.isLoading.value = true
                Session.sharedSession.sendRequest(MyProgramsRequest(page:1), handler: { (result) in
                    self?.isLoading.value = false
                    
                    switch result {
                    case .Success(let success):
                        self?.myPrograms.value.appendContentsOf(success.elements)
                    case .Failure(let error):
                        self?.error.value = error
                    }
                })
        }.addDisposableTo(disposeBag)
    }
}

extension Observable {
    func filterHasAccessToken() -> Observable {
        return self.filter{_ in Keychain()["accessToken"] != nil }
    }
}