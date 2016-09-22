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
    
    init(code: String) {
        self.code = code
    }
    
    var method: HTTPMethod {
        return .POST
    }
    
    var resourcePath: AnnictApiService.ResourcePath {
        return .OAuthToken
    }
    
    var parameters: AnyObject? {
        var params = [String:AnyObject]()
        params["client_id"] = AnnictApiConst.ClientId as AnyObject?
        params["client_secret"] = AnnictApiConst.ClientSecret as AnyObject?
        params["grant_type"] = "authorization_code" as AnyObject?
        params["redirect_uri"] = AnnictApiConst.RedirectUri as AnyObject?
        params["code"] = code as AnyObject?
        return params as AnyObject?
    }
    
    func responseFromObject(_ object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Void {
        let accessToken = try decodeValue(object, rootKeyPath: "access_token") as String
        Keychain()["accessToken"] = accessToken
    }

}
