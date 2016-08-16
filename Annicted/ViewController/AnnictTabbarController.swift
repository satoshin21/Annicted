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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Keychain()["accessToken"] == nil {
            let authViewController = storyboard?.instantiateViewControllerWithIdentifier("AuthViewController") as! AuthViewController
            let navigationController = UINavigationController(rootViewController: authViewController)
            presentViewController(navigationController, animated: true, completion: nil)
        }
    }
}
