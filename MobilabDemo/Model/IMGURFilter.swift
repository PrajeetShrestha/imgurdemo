//
//  Filter.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/28/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import Foundation

enum IMGURSection:String {
    case Hot  = "hot"// Default
    case Top  = "top"
    case User = "user"
    
    static let allValues = [Hot, Top, User]
    
}
//Only available with section
enum IMGURSort:String {
    case Viral  = "viral"// Default
    case Top    = "top"
    case Time   = "time"
    case Rising = "rising"
    static let allValues = [Viral, Top, Time, Rising]
}

//Change the date range of the request if 	section is "Top"
enum IMGURWindow:String {
    case Day   = "day"//Default
    case Week  = "week"
    case Month = "month"
    case Year  = "year"
    case All   = "all"
    static let allValues = [Day, Week, Month, Year, All]
}

/*
 Show or hide viral images from the 'user' section
 */
enum IMGURShowViral:String {
    case True = "true" //Default
    case False = "false"
    static let allValues = [True, False]
}


class IMGURFilter {
    var section:IMGURSection?             = .Hot
    var window:IMGURWindow?               = .Day
    var sort:IMGURSort?                   = .Viral
    var shouldFilterViral:IMGURShowViral? = .True
    var page:Int                          = 0
    
    /*
     Saves IMGURFilter object as Dictionary object into the userDefaults supplied by the client.
     If no default object is provided then standardUserDefaults is set as default.
     */
    func saveToUserDefaultsAsDictionary(defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()) {
        var filterDictionary = [String:AnyObject]()
        filterDictionary =
            [
                "section":self.section!.rawValue,
                "window":self.window!.rawValue,
                "sort":self.sort!.rawValue,
                "shouldFilterViral":self.shouldFilterViral!.rawValue,
                "page":0 //Page is added as 0 becausse we dont want page to be saved. User will browse from the beginning with previous filter.
        ]
        defaults.setObject(filterDictionary, forKey: kIMGURFilterDefaultKey)
        defaults.synchronize()  
    }
    
    func description () -> [String:AnyObject] {
        var filterDictionary = [String:AnyObject]()
        filterDictionary =
            [
                "section":self.section!.rawValue,
                "window":self.window!.rawValue,
                "sort":self.sort!.rawValue,
                "shouldFilterViral":self.shouldFilterViral!.rawValue,
                "page":self.page
        ]
        return filterDictionary
    }
    
    
    /*
     Retrieves IMGURFilter object from the defaults object provided by the client.
     Fetched from the standardUserDefaults by default.
     This method will return a default filter if no filters found stored in user defaults previously.
     */
    class func getFilterFromUserDefaults(defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()) -> IMGURFilter? {
        
        guard let filterDic =  defaults.objectForKey(kIMGURFilterDefaultKey) else  {
            return nil
        }
        
        let sectionValue           = filterDic.objectForKey("section") as? String
        let windowValue            = filterDic.objectForKey("window") as? String
        let sortValue              = filterDic.objectForKey("sort") as? String
        let shouldFilterViralValue = filterDic.objectForKey("shouldFilterViral") as? String
        let pageValue              = filterDic.objectForKey("page") as? Int
        
        let filter = IMGURFilter()
        filter.section           = IMGURSection.init(rawValue: sectionValue!)
        filter.window            = IMGURWindow.init(rawValue: windowValue!)
        filter.sort              = IMGURSort.init(rawValue: sortValue!)
        filter.shouldFilterViral = IMGURShowViral.init(rawValue: shouldFilterViralValue!)
        filter.page              = pageValue!
        return filter
    }
    
    
    class func hot() -> IMGURFilter {
        let filter = IMGURFilter()
        return filter
    }
    
    class func top() -> IMGURFilter {
        let filter = IMGURFilter()
        filter.section           = .Top
        filter.window            = .Day
        return filter
    }
    
    class func user() -> IMGURFilter {
        let filter = IMGURFilter()
        filter.section           = .User
        filter.sort              = .Viral
        return filter
    }
}