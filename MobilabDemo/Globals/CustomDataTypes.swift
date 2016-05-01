//
//  TypeAliases.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/28/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

//UserDefault Key
let kIMGURFilterDefaultKey = "kIMGURFilterDefaultKey"

//Notification
let kEndOfListReached = "kEndOfListReached"

typealias SuccessBlock = ((response:AnyObject?) -> ())
typealias FailureBlock = ((message:String?) -> ())