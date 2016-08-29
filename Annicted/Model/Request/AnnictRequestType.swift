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
import KeychainAccess

class AnnictApiConst {
    // client id
    static let ClientId = AnnictedKeys().annictClientId()
    
    static let ClientSecret = AnnictedKeys().annictClientSecret()
    
    static let BaseUrl = "https://api.annict.com/v1"
    
    static let OAuthAuthorize = "/oauth/authorize"
    
    static let RedirectUri = "https://jp.hatenadiary.satoshin21/redirect_uri"
}

protocol AnnictRequestType: RequestType {
}

extension AnnictRequestType {
    var baseURL: NSURL {
        return NSURL(string: AnnictApiConst.BaseUrl)!
    }
    
    var requestToken: String? {
        return Keychain()["accessToken"]
    }
}

extension AnnictRequestType where Response: Decodable {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
