//
//  MyProgramsViewModel.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import RxSwift
import RxRealm
import RealmSwift
import RxAlamofire
import RxCocoa
import SwiftyJSON
import KeychainAccess
import ObjectMapper

class MyProgramsViewModel {
    
    let myPrograms: Observable<(Results<MyProgram>)>
    
    let onLoading = Variable<Bool>(false)
    
    let disposeBag = DisposeBag()
    
    init () {
        do {
            let realm = try Realm()
            myPrograms = realm.objects(MyProgram).asObservableChangeset().map({$0.0})
        } catch let e {
            fatalError("MyProgramsViewModel initialized error: (\(e))")
        }
        
        onLoading
            .asDriver()
            .drive(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible).addDisposableTo(disposeBag)
    }
    
    func requestMyPrograms() -> Observable<JSON> {
        
        guard let accessToken = Keychain()["accessToken"] else {
            return Observable.error(AnnictErrorType.ParseError)
        }
        
        onLoading.value = true
        let url = AnnictApiService.ResourcePath.MePrograms.path
        let params: [String:AnyObject] = ["access_token":accessToken]
        
        return requestJSON(.GET, url, parameters: params, encoding: .URLEncodedInURL, headers: nil)
            .observeOn(MainScheduler.instance).map({JSON($0.1)}).doOnCompleted({ [weak self] _ in self?.onLoading.value = false}).doOnNext({ (json) in
                guard let programs = json["programs"].array else {
                    return
                }
                let mapper = Mapper<MyProgram>()
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    
                    programs
                        .flatMap({mapper.map($0.dictionaryObject)})
                        .forEach({realm.add($0, update: true)})
                    try realm.commitWrite()
                } catch {}
                
            })
    }
    
}
