//
//  PaginationResponse.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/24.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import Foundation
import Himotoki

struct PaginationResponse<E: Decodable>: PaginationResponseType {
    typealias Element = E
    
    let elements: [Element]
    
    let previousPage: Int?
    let nextPage: Int?
}
