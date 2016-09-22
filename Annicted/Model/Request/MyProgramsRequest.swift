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
import KeychainAccess

struct MyProgramsRequest: PaginationRequestType {
    let page: Int
    let accessToken: String
    
    init(page: Int = 1) {
        self.page = page
        accessToken = Keychain()["accessToken"]!
    }
    
    // MARK: RequestType
    typealias Response = PaginationResponse<MyProgram>
    
    var method: HTTPMethod {
        return .GET
    }
    
    var resourcePath: AnnictApiService.ResourcePath {
        return .MePrograms
    }
    
    var parameters: AnyObject? {
        return ["per_page": 50, "page": page,"access_token":accessToken]
    }
    
    // MARK: PaginationRequestType
    static func requestWithPage(_ page: Int) -> MyProgramsRequest {
        return MyProgramsRequest(page: page)
    }
    
    func responseFromObject(_ object: AnyObject, URLResponse: HTTPURLResponse) throws -> Response {
        print(object)
        let elements = try decodeArray(object, rootKeyPath: "programs") as [Response.Element]
        return Response(elements: elements)
    }
}
