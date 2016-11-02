//
//  RedditEntry.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/01/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

protocol Meta {
    static func url()->String
}

class RedditEntry: Object {
    
    dynamic var id : String = ""
    dynamic var title : String = ""
    dynamic var author : String = ""
    dynamic var created_utc : Date? = nil
    dynamic var thumbnail : String = ""
    dynamic var num_comments : Int = 0
    dynamic var subreddit : String = ""
    dynamic var link : String = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}

//MARK: - Mappable

extension RedditEntry : Mappable{
    func mapping(map: Map) {
        id <- map["data.id"]
        title <- map["data.title"]
        author <- map["data.author"]
        
        if let date_utc = (map["data.created_utc"].currentValue as? Int ){
            created_utc = Date(timeIntervalSince1970: TimeInterval(date_utc))
        }
        
        if let thumbnailURLString = (map["data.thumbnail"].currentValue as? String), let url = URL(string : thumbnailURLString), UIApplication.shared.canOpenURL(url){
                thumbnail = thumbnailURLString
        }
        
        num_comments <- map["data.num_comments"]
        subreddit <- map["data.subreddit"]
        link <- map["data.url"]
    }
}

//MARK: - Meta

extension RedditEntry : Meta{
    static func url()->String {
        return "https://www.reddit.com/top/.json"
    }
}
