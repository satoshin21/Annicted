//
//  NSURL+Easy.swift
//  Kakeibon
//
//  Created by SatoshiN21 on 2016/06/29.
//  Copyright © 2016年 H Frontier Co., Ltd. All rights reserved.
//

import Foundation

extension URL {
    
    var baseURLString: String{
        guard let query = query else {
            return self.absoluteString
        }
        
        return absoluteString.replacingOccurrences(of: "?\(query)", with: "")
    }
    
    var queryDictionary: [String:String]? {
        guard let query = query else {
            return nil
        }
        
        var params = [String:String]()
        query.components(separatedBy: "&").map({$0.components(separatedBy: "=")}).filter({$0.count == 2}).forEach { (keyParam) in
            params[keyParam[0]] = keyParam[1]
        }
        return params
    }
}
