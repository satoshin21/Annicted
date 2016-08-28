//
//  MyProgramsRequest.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/24.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

struct MyProgramsRequest: PaginationRequestType {
    let page: Int
    
    init(page: Int = 1) {
        self.page = page
    }
    
    // MARK: RequestType
    typealias Response = PaginationResponse<MyProgram>
    
    var method: HTTPMethod {
        return .GET
    }
    
    var path: String {
        return "/me/programs"
    }
    
    var parameters: AnyObject? {
        return ["per_page": 50, "page": page]
    }
    
    // MARK: PaginationRequestType
    static func requestWithPage(page: Int) -> MyProgramsRequest {
        return MyProgramsRequest(page: page)
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        let elements = try decodeArray(object, rootKeyPath: "programs") as [Response.Element]
        return Response(elements: elements)
    }
}
