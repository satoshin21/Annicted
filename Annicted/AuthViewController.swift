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
import RxCocoa

class AuthViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params: [String:AnyObject] = ["client_id":AnnictApiService.ClientId,
                                         "response_type":"code",
                                         "redirect_uri":AnnictApiService.RedirectUri,
                                         "scope":"read+write"]
        webView.loadRequest(.OAuthAuthorize, queryParams: params)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let query = request.URL?.queryDictionary where request.URL?.host == "jp.hatenadiary.satoshin21" {
            
            var params = [String:AnyObject]()
            params["client_id"] = AnnictApiService.ClientId
            params["client_secret"] = AnnictApiService.ClientSecret
            params["grant_type"] = "authorization_code"
            params["redirect_uri"] = AnnictApiService.RedirectUri
            if let code = query["code"] {
                params["code"] = code
            }
            
            requestJSON(.POST, AnnictApiService.ResourcePath.OAuthToken.path, parameters: params, encoding: .URLEncodedInURL, headers: nil).observeOn(MainScheduler.instance).subscribe(onNext: { (response, responseObject) in
                
                responseObject
                
                }, onError: { (e) in
                    print(e)
                }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
            
            
            return false
        }
        return true
    }
}

