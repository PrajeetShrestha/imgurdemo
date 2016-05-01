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
    
    var f:IMGURFilter!
    
    override func setUp() {
        super.setUp()
        f  = IMGURFilter()
    }
    func testCreatePathWhenSectionIsTop() {
        
        f.section = .Top
        let path = IMGURApiService.createPath(f)
        XCTAssertEqual("top/day/0?showViral=true", path)
    }
    
    func testCreatePathWhenSectionIsUser() {
        f.section = .User
        let path = IMGURApiService.createPath(f)
        XCTAssertEqual("user/viral/0?showViral=true", path)
    }
    
    func testCreatePathWhenSectionIsHot() {
        f.section = .Hot
        let path = IMGURApiService.createPath(f)
        XCTAssertEqual("hot/0?showViral=true", path)
    }
    
    func testCreatePathForDifferentPages() {
        f.page = 0
        var path = IMGURApiService.createPath(f)
        
        XCTAssertEqual("hot/0?showViral=true", path)
        f.page = 1
        path = IMGURApiService.createPath(f)
        XCTAssertEqual("hot/1?showViral=true", path)
        
        f.page = 2
        path = IMGURApiService.createPath(f)
        XCTAssertEqual("hot/2?showViral=true", path)
    }
    

    
}
