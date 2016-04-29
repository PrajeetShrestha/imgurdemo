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
let kIMGURHeader  = ["Authorization": "Client-ID e4b57d1339155a7" ]
let kIMGURBaseURL = "https://api.imgur.com/3/"
let kIMGURGallery = kIMGURBaseURL + "gallery/"

class IMGURApiService: NSObject {
    class func getGalleryAt(path:String, success:SuccessBlock, failure:FailureBlock) {
        print("Initiating GET request at \(path)")
        Alamofire.request(.GET, path + kIMGURGallery ,parameters: nil, encoding: .URL,headers: kIMGURHeader)
            .responseJSON {
                response in
                if let r = response.result.value {
                    let data = r["data"]
                    let images = Mapper<IMGURImage>().mapArray(data)
                    for img in images! {
                        print(img.title!)
                    }
                }
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
    
    class func createPath(filter:IMGURFilter, page:Int) -> String {
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
            
            path.appendContentsOf("/\(page)")
            if let shouldShowViral = filter.shouldFilterViral{
                let str = "?showViral=\(shouldShowViral.rawValue)"
                path.appendContentsOf(str)
            }
        }
        return path
    }
    
}
