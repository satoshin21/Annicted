//
//  MyProgram.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/15.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
//import RealmSwift
//import ObjectMapper
//
//class MyProgramOld: Object {
//    dynamic var id: Int = 0
//    dynamic var startedAt: NSDate?
//    dynamic var isRebroadcast: Bool = false
//    dynamic var channelId: Int = 0
//    dynamic var channelName: String = ""
//    // var works: [Work]
//    // var episodes: [Episode]
//    
//    required convenience init?(_ map: Map) {
//        self.init()
//        mapping(map)
//    }
//    
//    override class func primaryKey() -> String {
//        return "id"
//    }
//}
//
//extension MyProgramOld: Mappable {
//    func mapping(map: Map) {
//        id <- map["id"]
//        startedAt <- (map["started_at"],AnnictDateTransform())
//        isRebroadcast <- map["is_rebroadcast"]
//        channelId <- map["channel.id"]
//        channelName <- map["channel.name"]
//    }
//}