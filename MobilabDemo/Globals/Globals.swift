//
//  TypeAliases.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/28/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//
import UIKit
//UserDefault Key
let kIMGURFilterDefaultKey = "kIMGURFilterDefaultKey"

//Notification
let kEndOfListReached = "kEndOfListReached"

let kAppThemeColor =  UIColor(netHex:0x1A8B01)
typealias SuccessBlock = ((response:AnyObject?) -> ())
typealias FailureBlock = ((message:String) -> ())