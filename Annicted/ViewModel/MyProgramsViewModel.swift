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
import KeychainAccess
import Himotoki

class MyProgramsViewModel {
    
    let refreshTrigger = PublishSubject<Void>()
    
    var pageIndex = 1
    
    let myPrograms = Variable<[MyProgram]>([])
    
    let error = Variable<Error?>(nil)
    
    let disposeBag = DisposeBag()
    
    let isLoading = Variable<Bool>(false)
    
    init () {
        
        refreshTrigger
            .filterHasAccessToken()
            .filter({!self.isLoading.value})
        .subscribe {[weak self] (event) in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.pageIndex = 1
                weakSelf.isLoading.value = true
                Session.shared.send(MyProgramsRequest(page:weakSelf.pageIndex), handler: { (result) in
                    self?.isLoading.value = false
                    
                    switch result {
                    case .success(let success):
                        self?.myPrograms.value = success.elements
                    case .failure(let error):
                        switch error {
                        case .responseError(let responseError as DecodeError):
                            print(responseError.description)
                            self?.error.value = responseError
                        default:
                            self?.error.value = error
                            
                        }
                    }
                })
        }.addDisposableTo(disposeBag)
        
        isLoading.asDriver()
            .drive(UIApplication.shared.rx.networkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
    }
}

extension Observable {
    func filterHasAccessToken() -> Observable {
        return self.filter{_ in Keychain()["accessToken"] != nil }
    }
}
