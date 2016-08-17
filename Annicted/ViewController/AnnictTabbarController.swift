//
//  AnnictTabbarController.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/16.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import KeychainAccess

class AnnictTabbarController: UITabBarController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // アクセストークンが存在しない場合に限り認証画面を表示
        if Keychain()["accessToken"] == nil || Keychain()["accessToken"] == "" {
            let authViewController = storyboard?.instantiateViewControllerWithIdentifier("AuthViewController") as! AuthViewController
            let navigationController = UINavigationController(rootViewController: authViewController)
            presentViewController(navigationController, animated: true, completion: nil)
        }
    }
}
