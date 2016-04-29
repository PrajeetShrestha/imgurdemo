//
//  FilterViewControllerTests.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import XCTest
@testable import MobilabDemo

class FilterViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreatePathWhenSectionIsTop() {
        var f               = IMGURFilter()
        f.section           = .Top
        f.sort              = .Viral
        f.window            = .Day
        f.shouldFilterViral = .True
        
        let path = IMGURApiService.createPath(f, page: 0)
        XCTAssertEqual("top/day/0?showViral=true", path)
    }
    
    func testCreatePathWhenSectionIsUser() {
        var f               = IMGURFilter()
        f.section           = .User
        f.sort              = .Viral
        f.window            = .Day
        f.shouldFilterViral = .True
        
        let path = IMGURApiService.createPath(f, page: 0)
        XCTAssertEqual("user/viral/0?showViral=true", path)
    }
    
    func testCreatePathWhenSectionIsHot() {
        var f               = IMGURFilter()
        f.section           = .Hot
        f.sort              = .Viral
        f.window            = .Day
        f.shouldFilterViral = .True
        
        let path = IMGURApiService.createPath(f, page: 0)
        XCTAssertEqual("hot/0?showViral=true", path)
    }
    
    func testCreatePathForDifferentPages() {
        
        var f               = IMGURFilter()
        f.section           = .Hot
        f.sort              = .Viral
        f.window            = .Day
        f.shouldFilterViral = .True
        
        var path = IMGURApiService.createPath(f, page: 0)
        XCTAssertEqual("hot/0?showViral=true", path)
        
        path = IMGURApiService.createPath(f, page: 1)
        XCTAssertEqual("hot/1?showViral=true", path)
        
        
        path = IMGURApiService.createPath(f, page: 2)
        XCTAssertEqual("hot/2?showViral=true", path)
        
    }
    
}
