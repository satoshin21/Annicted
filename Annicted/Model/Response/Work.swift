//
//  Work.swift
//  Annicted
//
//  Created by Satoshi Nagasaka on 2016/08/27.
//  Copyright © 2016年 SatoshiN21. All rights reserved.
//

import UIKit
import Himotoki
import Timepiece

struct Work: Decodable {
    
    let id: Int
    let title: String
    let titleKana: String
    let media: String
    let mediaText: String
    let seasonName: String
    let seasonNameText: String
    let releasedOn: NSDate?
    let releasedOnAbout: String
    let officialSiteUrl: String
    let wikipediaUrl: String
    let twitterUsername: String
    let twitterHashtag: String
    let episodesCount: Int
    let watchersCount: Int
    
    
    static func decode(e: Extractor) throws -> Work {
        return try Work(id:     e <| "id",
             title:             e <| "title",
             titleKana:         e <| "title_kana",
             media:             e <| "media",
             mediaText:         e <| "media_text",
             seasonName:        e <| "season_name",
             seasonNameText:    e <| "season_name_text",
             releasedOn:        NSDate(string: e <|? "released_on", format: "yyyy-MM-dd"),
             releasedOnAbout:   e <| "released_on_about",
             officialSiteUrl:   e <| "official_site_url",
             wikipediaUrl:      e <| "wikipedia_url",
             twitterUsername:   e <| "twitter_username",
             twitterHashtag:    e <| "twitter_hashtag",
             episodesCount:     e <| "episodes_count",
             watchersCount:     e <| "watchers_count")
    }
}
