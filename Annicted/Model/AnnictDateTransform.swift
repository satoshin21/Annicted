//
//  AnnictDateTransform.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import ObjectMapper

class AnnictDateTransform: DateTransform {
    override func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let dateStr = value as? String {
            return NSDate(iso8601String: dateStr)
        }
        return nil
    }
}
