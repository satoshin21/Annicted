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
import KeychainAccess

class AuthViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "認証"
        
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
            
            requestJSON(.POST, AnnictApiService.ResourcePath.OAuthToken.path, parameters: params, encoding: .URLEncodedInURL, headers: nil).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self](response, responseObject) in
                
                if let dict = responseObject as? [String:AnyObject],let accessToken = dict["access_token"] as? String {
                    Keychain()["accessToken"] = accessToken
                }
                self?.dismissViewControllerAnimated(true, completion: nil)
                
                }, onError: {[weak self] (e) in
                    let alert = UIAlertController(e: e)
                    self?.presentViewController(alert, animated: true, completion: nil)
                }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
            
            
            return false
        }
        return true
    }
}

