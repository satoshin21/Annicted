//
//  MyProgram.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import ObjectMapper

class MyProgram {
    var id: Int!
    var startedAt: NSDate?
    var isRebroadcast: Bool!
    var channelId: Int!
    var channelName: String!
    // var works: [Work]
    // var episodes: [Episode]
    
    required init(_ map: Map) {
        mapping(map)
    }
}

extension MyProgram: Mappable {
    func mapping(map: Map) {
        id <- map["id"]
        startedAt <- (map["started_at"],AnnictDateTransform())
        isRebroadcast <- map["is_rebroadcast"]
        channelId <- map["channel.id"]
        channelName <- map["channel.name"]
    }
}