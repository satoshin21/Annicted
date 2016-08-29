//
//  MyProgram.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/24.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import Foundation
import Himotoki

struct MyProgram: Decodable {
    let id: Int
    let startedAt: NSDate
    let isRebroadcast: Bool
    let channelId: Int
    let channelName: String
    let work: Work
    let episode: Episode
    
    static func decode(e: Extractor) throws -> MyProgram {
        
       return try MyProgram(id: e <| "id",
                  startedAt: NSDate(iso8601String: e <|? "started_at")!,
                  isRebroadcast: e <| "is_rebroadcast",
                  channelId: e <| ["channel","id"],
                  channelName: e <| ["channel","name"],
                  work: e <| "work",
                  episode: e <| "episode")
    }
}