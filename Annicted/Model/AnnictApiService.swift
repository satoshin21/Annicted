//
//  AnnictApiService.swift
//  Annicted
//
//  Created by 長坂悟志 on 2016/07/21.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

class AnnictApiService {
    // client id
    static var ClientId = "5e0890ed674ec454caca71c0d8e530ba6f74edfff033a32fce439a4441bd1884"
    
    static var BaseUrl = "https://api.annict.com"
    
    static var OAuthAuthorize = "/oauth/authorize"
    
    enum ResourcePath: String {
        case OAuthAuthorize = "/oauth/authorize"    // 認証ページ
        case OAuthToken     = "/oauth/token"        // アクセストークン取得
        case OAuthRevoke    = "/oauth/revoke"       // アクセストークン失効
        case Works          = "/v1/works"           // 作品情報取得
        case Episodes       = "/v1/episodes"        // エピソード情報取得
        case Records        = "/v1/records"         // エピソードへの記録
        case MeStatuses     = "/v1/me/statuses"     // 作品のステータス設定
        case MeWorks        = "/v1/me/works"        // 自分がステータスを設定している作品の情報
        case MePrograms     = "/v1/me/programs"     // 放送予定を取得
        
        var path: String {
            return AnnictApiService.BaseUrl + rawValue
        }
    }
}
