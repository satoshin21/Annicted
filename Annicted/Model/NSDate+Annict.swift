//
//  NSDate+Annict.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import Foundation

let AnnictDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

extension Date {
    
    init?(iso8601String: String?) {
        guard let iso8601String = iso8601String,let date = Date.stringToDate(iso8601String) else {
            return nil
        }
        (self as NSDate).init(timeInterval:0, since: date)
    }
    
    init?(string: String?,format:  String) {
        guard let string = string,let date = Date.stringToDate(string,format: format) else {
            return nil
        }
        (self as NSDate).init(timeInterval:0, since: date)
    }
    
    fileprivate static func stringToDate(_ iso8601String: String,format: String = AnnictDateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: iso8601String)
    }
}
