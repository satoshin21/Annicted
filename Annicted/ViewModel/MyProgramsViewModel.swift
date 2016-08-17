//
//  MyProgramsViewModel.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import RxSwift
import ReactiveRealm
import RealmSwift
import RxAlamofire
import SwiftyJSON
import KeychainAccess

class MyProgramsViewModel {
    
    let myPrograms: Observable<Results<MyProgram>>
    
    init () {
        do {
            let realm = try Realm()
            myPrograms = realm.rx_objects(MyProgram)
        } catch let e {
            fatalError("MyProgramsViewModel initialized error: (\(e))")
        }
    }
    
    func requestMyPrograms() -> Observable<JSON> {
        guard let accessToken = Keychain()["accessToken"] else {
            return Observable.error(AnnictErrorType.ParseError)
        }
        
        let url = AnnictApiService.ResourcePath.MePrograms.path
        let params: [String:AnyObject] = ["access_token":accessToken]
        return requestJSON(.GET, url, parameters: params, encoding: .URLEncodedInURL, headers: nil).observeOn(MainScheduler.instance).map({JSON($0.1)})
        
    }
}
