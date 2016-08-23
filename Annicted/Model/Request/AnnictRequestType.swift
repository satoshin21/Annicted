//
//  AnnictRequestType.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/24.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import APIKit
import Himotoki
import WebLinking
import Keys

class AnnictApiConst {
    // client id
    static let ClientId = AnnictedKeys().annictClientId()
    
    static let ClientSecret = AnnictedKeys().annictClientSecret()
    
    static let BaseUrl = "https://api.annict.com"
    
    static let OAuthAuthorize = "/oauth/authorize"
    
    static let RedirectUri = "https://jp.hatenadiary.satoshin21/redirect_uri"
}

protocol AnnictRequestType: RequestType {
    
}

extension AnnictRequestType {
    var baseURL: NSURL {
        return NSURL(string: AnnictApiConst.BaseUrl)!
    }
}

extension AnnictRequestType where Response: Decodable {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}

extension AnnictRequestType where Response: PaginationResponseType {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        var previousPage: Int?
        if let previousURI = URLResponse.findLink(relation: "prev")?.uri,
            let queryItems = NSURLComponents(string: previousURI)?.queryItems {
            previousPage = queryItems
                .filter { $0.name == "page" }
                .first
                .flatMap { $0.value }
                .flatMap { Int($0) }
        }
        
        var nextPage: Int?
        if let nextURI = URLResponse.findLink(relation: "next")?.uri,
            let queryItems = NSURLComponents(string: nextURI)?.queryItems {
            nextPage = queryItems
                .filter { $0.name == "page" }
                .first
                .flatMap { $0.value }
                .flatMap { Int($0) }
        }
        
        let elements = try decodeArray(object, rootKeyPath: "items") as [Response.Element]
        
        return Response(elements: elements, previousPage: previousPage, nextPage: nextPage)
    }
}
