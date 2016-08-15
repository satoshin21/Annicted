//
//  NSDate+Annict.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import Foundation

let AnnictDateFormat = "yyyy-MM-ddTHH:mm:ssZ"

extension NSDate {
    
    convenience init?(iso8601String: String?) {
        guard let iso8601String = iso8601String,let date = NSDate.stringToDate(iso8601String) else {
            return nil
        }
        self.init(timeInterval:0, sinceDate: date)
    }
    
    private static func stringToDate(iso8601String: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = AnnictDateFormat
        return formatter.dateFromString(iso8601String)
    }
}