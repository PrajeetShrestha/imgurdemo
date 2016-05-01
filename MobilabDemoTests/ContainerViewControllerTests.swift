//
//  ContainerViewControllerTests.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import XCTest
import UIKit
@testable import MobilabDemo
class ContainerViewControllerTests: XCTestCase {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListViewControllerInitialization() {
        
        let listController = self.mainStoryboard.instantiateViewControllerWithIdentifier("ListViewController") as? ListViewController
        
        if let _ = listController {
            XCTAssert(true,"ListViewController in storyboard does have class ListViewController")
        } else {
            XCTAssert(false,"ListViewController in storyboard doesn't have class ListViewController")
        }
    }
    
    func testGridViewControllerInitialization() {
        let gridController = self.mainStoryboard.instantiateViewControllerWithIdentifier("GridViewController") as? GridViewController
        if let _ = gridController {
            XCTAssert(true,"GridViewController in storyboard does have class as GridViewController")
        } else {
            XCTAssert(false,"GridViewController in storyboard doesnt have class as GridViewController")
        }
    }
    
    func testIfAPIIsCalledWithStoredFilterIfExists() {
        let cntController = mainStoryboard.instantiateViewControllerWithIdentifier("ContainerViewController") as! ContainerViewController
        
    }


}
