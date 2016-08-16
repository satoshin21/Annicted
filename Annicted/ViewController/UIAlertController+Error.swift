//
//  UIAlertController+Error.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/16.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit

let UnexpectedErrorTitle = "予期しないエラーが発生しました"

extension UIAlertController {
    
    convenience init(e: ErrorType) {
        self.init(error:e as NSError)
    }
    
    convenience init(error: NSError) {
        self.init(errorTitle: error.localizedDescription,errorMessage: error.localizedFailureReason)
    }
    
    convenience init(errorTitle: String,errorMessage: String? = nil) {
        self.init(title: errorMessage, message: errorMessage, preferredStyle: .Alert)
        addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    }
}