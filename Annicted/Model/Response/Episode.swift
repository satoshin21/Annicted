//
//  Episode.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/27.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import Himotoki

struct Episode: Decodable {
    
    let id: Int
    let number: String
    let numberText: String
    let sortNumber: Int
    let title: String?
    let recordsCount: Int
    
    static func decode(_ e: Extractor) throws -> Episode {
        return try Episode(id: e <| "id",
                           number: e <| "number",
                           numberText: e <| "number_text",
                           sortNumber: e <| "sort_number",
                           title: e <|? "title",
                           recordsCount: e <| "records_count")
    }
}
