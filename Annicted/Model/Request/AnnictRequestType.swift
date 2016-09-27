//
//  AnnictRequestType.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/24.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import APIKit
import Himotoki
import Keys
import KeychainAccess

class AnnictApiConst {
    // client id
    static let ClientId = AnnictedKeys().annictClientId()
    
    static let ClientSecret = AnnictedKeys().annictClientSecret()
    
    static let BaseUrl = "https://api.annict.com"
    
    static let OAuthAuthorize = "/oauth/authorize"
    
    static let RedirectUri = "https://jp.hatenadiary.satoshin21/redirect_uri"
}

protocol AnnictRequestType: Request {
    
    var resourcePath: AnnictApiService.ResourcePath { get }
}

extension AnnictRequestType {
    
    var baseURL: URL {
        return URL(string: AnnictApiConst.BaseUrl)!
    }
    
    var requestToken: String? {
        return Keychain()["accessToken"]
    }
    
    var path: String {
        return resourcePath.rawValue
    }
}

extension AnnictRequestType where Response: Decodable {
    func responseFromObject(_ object: AnyObject, URLResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
