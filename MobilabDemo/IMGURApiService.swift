//
//  IMGURApiService.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
//e4b57d1339155a7
let kIMGURHeader  = ["Authorization": "Client-ID e4b57d1339155a7" ]
let kIMGURBaseURL = "https://api.imgur.com/3/"
let kIMGURGallery = kIMGURBaseURL + "gallery/"

class IMGURApiService: NSObject {
    
    func getGalleryImages(filter:IMGURFilter,success:([IMGURImage]? -> ()), failure:FailureBlock) {
        
        let path = IMGURApiService.createPath(filter)
        
        Alamofire.request(.GET, kIMGURGallery + path, parameters: nil, encoding: .URL,headers: kIMGURHeader)
            .responseJSON {
                response in
                guard
                    let r = response.result.value,
                    let d = r["data"],
                    let status = r["status"] as? Int,
                    let images = d as? [[String:AnyObject]]
                    where status == 200 else {
                        
                        if let response = response.result.value,
                            let data = response["data"],
                            let errorMessage = data!["error"] as? String {
                            failure(message: errorMessage)
                        } else {
                            failure(message: "There is some problem in network")
                        }
                        return
                }
                
                var imgurImages = [IMGURImage]()
                for img in images {
                    if let isAlbum = img["is_album"] as? Bool,
                        let isAnimated = img["animated"] as? Bool,
                        let image = Mapper<IMGURImage>().map(img)
                        where isAlbum == false  && isAnimated == false {
                        imgurImages.append(image)
                    }
                }
                success(imgurImages)
        }
    }
    
    /*
     Imgur gallery section consists of 5 filters.
     1. section
     2. sort       - Depends on section. Only activates when  "user" section is selected.
     3. window     - Depends on section. Only activates when  "top" section is selected.
     4. page
     5. showViral
     */
    
    class func createPath(filter:IMGURFilter) -> String {
        var path = ""
        if let section = filter.section?.rawValue {
            path = section
            if let sort = filter.sort
                where section == "user" {
                let str = "/\(sort.rawValue)"
                path.appendContentsOf(str)
            }
            
            if let window = filter.window
                where section == "top" {
                let str = "/\(window.rawValue)"
                path.appendContentsOf(str)
                
            }
            
            path.appendContentsOf("/\(filter.page)")
            if let shouldShowViral = filter.shouldFilterViral{
                let str = "?showViral=\(shouldShowViral.rawValue)"
                path.appendContentsOf(str)
            }
        }
        return path
    }
    
}
