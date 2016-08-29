//: Playground - noun: a place where people can play

import Cocoa

//var str = "Hello, playground"
//
//let iso8601String = "2016-01-07T16:50:00.000Z"
//
//let formatter = NSDateFormatter()
//formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//formatter.timeZone = NSTimeZone(name: "JP")
//formatter.locale = NSLocale(localeIdentifier: "ja_JP")
//let date =  formatter.dateFromString(iso8601String)
//
//date.string
//print(date)
//
//let AnnictDateFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ"
//
//extension NSDate {
//    
//    convenience init?(iso8601String: String?) {
//        guard let iso8601String = iso8601String,let date = NSDate.stringToDate(iso8601String) else {
//            return nil
//        }
//        self.init(timeInterval:0, sinceDate: date)
//    }
//    
//    convenience init?(string: String?,format:  String) {
//        guard let string = string,let date = NSDate.stringToDate(string,format: format) else {
//            return nil
//        }
//        self.init(timeInterval:0, sinceDate: date)
//    }
//    
//    private static func stringToDate(iso8601String: String,format: String = AnnictDateFormat) -> NSDate? {
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = format
//        return formatter.dateFromString(iso8601String)
//    }
//}