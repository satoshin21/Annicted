//
//  AuthorizeRequest.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/09/13.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import APIKit
import Himotoki
import KeychainAccess

class AuthorizeRequest: AnnictRequestType {
    
    let code: String
    
    // MARK: RequestType
    typealias Response = Void
    
    init(code: String) {
        self.code = code
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var resourcePath: AnnictApiService.ResourcePath {
        return .OAuthToken
    }
    
    var parameters: Any? {
        var params = [String:AnyObject]()
        params["client_id"] = AnnictApiConst.ClientId as AnyObject?
        params["client_secret"] = AnnictApiConst.ClientSecret as AnyObject?
        params["grant_type"] = "authorization_code" as AnyObject?
        params["redirect_uri"] = AnnictApiConst.RedirectUri as AnyObject?
        params["code"] = code as AnyObject?
        return params
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> () {
        let accessToken = try decodeValue(object, rootKeyPath: "access_token") as String
        Keychain()["accessToken"] = accessToken
    }

}
