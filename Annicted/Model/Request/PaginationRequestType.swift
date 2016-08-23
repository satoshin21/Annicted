//
//  PaginationRequestType.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/24.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import Foundation
import APIKit

protocol PaginationRequestType: RequestType {
    associatedtype Response: PaginationResponseType
    
    var page: Int { get }
    
    func requestWithPage(page: Int) -> Self
}