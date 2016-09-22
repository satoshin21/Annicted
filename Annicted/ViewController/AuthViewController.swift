//
//  AuthViewController.swift
//  Annicted
//
//  Created by 長坂悟志 on 2016/06/30.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Keys
import KeychainAccess
import APIKit

class AuthViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "認証"
        
        let params: [String:AnyObject] = ["client_id":AnnictApiConst.ClientId as AnyObject,
                                          "response_type":"code" as AnyObject,
                                          "redirect_uri":AnnictApiConst.RedirectUri as AnyObject,
                                          "scope":"read+write" as AnyObject]
        webView.loadRequest(.OAuthAuthorize, queryParams: params)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        if let absoluteUrl = request.url?.absoluteString , absoluteUrl.hasPrefix(AnnictApiConst.RedirectUri),
            let query = request.url?.queryDictionary,let code = query["code"] {
            
            Session.sharedSession.sendRequest(AuthorizeRequest(code:code), callbackQueue: CallbackQueue.Main, handler: {[weak self] (result) in
                
                switch result {
                case .Success:
                    self?.dismissViewControllerAnimated(true, completion: nil)
                case .Failure(let error):
                    let alert = UIAlertController(e: error)
                    self?.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
        return true
    }
}

