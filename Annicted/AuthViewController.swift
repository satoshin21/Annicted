//
//  AuthViewController.swift
//  Annicted
//
//  Created by 長坂悟志 on 2016/06/30.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire

class AuthViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var hoge = Hoge()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let manager textField Manager.sharedInstance
        
        
        _ = self.textField.rx_text.debounce(0.7, scheduler: MainScheduler.instance).distinctUntilChanged().subscribeNext{ (text) in
            print(text)
        }
        
        //
        let intOb1 = PublishSubject<String>()
        let intOb2 = PublishSubject<Int>()
        
        _ = Observable.combineLatest(intOb1, intOb2) {
            "\($0) \($1)"
            }
            .subscribe {
                print($0)
        }
        
        intOb1.on(.Next("A"))
        intOb2.on(.Next(1))
        intOb1.on(.Next("B"))
        intOb2.on(.Next(2))
        
//        let request = rx_request(URLRequestConvertible).flatMap {
//            rx_responseResult(responseSerializer: Request.ObjectMapperSerializer("user"))
//            }.flatMap { Observable.just($1) }
//        
//        request.subscribe(onNext: { (user) in
//            // これでユーザーオブジェクトとしてデータを取得できている。
//            print (user)
//            }, onError: nil)
        
        
        let param = ["client_id":AnnictApi.ClientId,"response_type":"code","redirect_uri":"https://jp.hatenadiary.satoshin21/redirect_uri","scope":"read+write"]
        
        
//        let url = AnnictApi.BaseUrl + AnnictApi.OAuthAuthorize
        let url = "\(AnnictApi.BaseUrl + AnnictApi.OAuthAuthorize)?\(param.map({"\($0)=\($1)"}).joinWithSeparator("&"))"
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL?.absoluteString {
            print("URL:\(url)")
        }
        return true
    }
}

class Hoge: NSObject {
    var hoge: String = ""
}