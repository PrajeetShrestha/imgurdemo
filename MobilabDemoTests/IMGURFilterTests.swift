//
//  IMGURFilterTests.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/30/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import XCTest
@testable import MobilabDemo
class IMGURFilterTests: XCTestCase {
    let testDefault = NSUserDefaults(suiteName: "testing")
    var filter = IMGURFilter()
    
    func testSaveFilterToUserDefaults() {
        //After Invocking saveToUserDefaults following testCase must succeed
        filter.saveToUserDefaultsAsDictionary(testDefault!)
        if let _ = testDefault?.objectForKey(kIMGURFilterDefaultKey) {
            XCTAssert(true, "The filter is certainly saved in userDetaults")
        } else {
            XCTAssert(false, "The filter is certainly NOT saved in userDetaults")
        }
    }
    
    func testRetreiveFromUserDefaults() {
        filter.section = .User
        filter.page = 100
        filter.saveToUserDefaultsAsDictionary(testDefault!)
        if let f = IMGURFilter.getFilterFromUserDefaults(testDefault!) {
            self.filter = f
            XCTAssert(true, "Something fetched form userDefaults in filter key")
        } else {
            XCTAssert(false, "Nothing fetched form userDefaults in filter key")
        }
        
    }
    
    func testVerifySavedDataInUserDefaults() {
        filter.section = .User
        filter.page = 100
        filter.saveToUserDefaultsAsDictionary(testDefault!)
        let fetchedFilter = IMGURFilter.getFilterFromUserDefaults(testDefault!)!
        if fetchedFilter.section == .User && fetchedFilter.page == 100 {
            XCTAssert(true, "Fetched correct data from the user defaults")
        } else {
            XCTAssert(false, "Did not fetched correct data from the user defaults")
        }
    }
    
    override func tearDown() {
        testDefault?.removeObjectForKey(kIMGURFilterDefaultKey)
        super.tearDown()
        
    }
    
}
