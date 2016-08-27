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

extension AnnictAPI {
    
    struct MyProgramsRequest: AnnictRequestType,PaginationRequestType {
        let query: String
        let page: Int
        
        init(query: String, page: Int = 1) {
            self.query = query
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
            return ["q": query, "page": page]
        }
        
        // MARK: PaginationRequestType
        func requestWithPage(page: Int) -> MyProgramsRequest {
            return MyProgramsRequest(query: query, page: page)
        }
        
        func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
            
            let elements = try decodeArray(object, rootKeyPath: "programs") as [Response.Element]
            
            return Response(elements: elements)
        }
    }
}