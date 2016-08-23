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
    let fullName: String
    let stargazersCount: Int
    
    static func decode(e: Extractor) throws -> MyProgram {
        return try MyProgram(
            id:              e <| "id",
            fullName:        e <| "full_name",
            stargazersCount: e <| "stargazers_count"
        )
    }
}