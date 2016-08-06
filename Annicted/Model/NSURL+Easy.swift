//
//  NSURL+Easy.swift
//  Kakeibon
//
//  Created by SatoshiN21 on 2016/06/29.
//  Copyright © 2016年 H Frontier Co., Ltd. All rights reserved.
//

import Foundation

extension NSURL {
    
    var baseURLString: String{
        guard let query = query else {
            return self.absoluteString
        }
        
        return absoluteString.stringByReplacingOccurrencesOfString("?\(query)", withString: "")
    }
    
    var queryDictionary: [String:String]? {
        guard let query = query else {
            return nil
        }
        
        var params = [String:String]()
        let queries = query.componentsSeparatedByString("&")
        query.componentsSeparatedByString("&").map({$0.componentsSeparatedByString("=")}).filter({$0.count == 2}).forEach { (keyParam) in
            params[keyParam[0]] = keyParam[1]
            print("keyParam = \(keyParam)")
        }
        return params
    }
}