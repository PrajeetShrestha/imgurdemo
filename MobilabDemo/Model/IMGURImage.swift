//
//  IMGURImage.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/28/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class IMGURImage:Mappable {
    var objID:String?
    var title:String?
    var description:String?
    var width:Int?
    var height:Int?
    var views:Int?
    var ups:Int?
    var downs:Int?
    var score:Int?
    var isAlbum:Bool?
    var link:String?
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        objID       <- map["id"]
        title       <- map["title"]
        description <- map["description"]
        width       <- map["width"]
        height      <- map["height"]
        views       <- map["views"]
        ups         <- map["ups"]
        downs       <- map["downs"]
        score       <- map["score"]
        isAlbum     <- map["is_album"]
        link        <- map["link"]
    }
}
