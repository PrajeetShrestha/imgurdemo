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
    case User = "user"
    case Top  = "top"

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
}

struct IMGURFilter {
    var section:IMGURSection?
    var window:IMGURWindow?
    var sort:IMGURSort?
    var shouldFilterViral:IMGURShowViral? = .False
}