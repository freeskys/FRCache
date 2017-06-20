//
//  FRCacheTests.swift
//  FRCache-Example
//
//  Created by Harditya on 6/20/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import XCTest

class FRCacheTests: XCTestCase {
    
    let key = "FRCache"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        FRCache.removeCache(withKey: key)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSaveGetArrayIntData() {
        let theArray = [32, 4]
        
        FRCache.cacheArray(array: theArray,
                           withKey: key)
        let theArrayResult = FRCache.getCacheArray(withKey: key) as [Int]
        
        XCTAssertEqual(theArray, theArrayResult)
    }
    
    func testSaveGetArrayStringData() {
        let theArray = ["Testing 1", "Iki Bueyo", "Hah?"]
        
        FRCache.cacheArray(array: theArray,
                           withKey: key)
        let theArrayResult = FRCache.getCacheArray(withKey: key) as [String]
        
        XCTAssertEqual(theArray, theArrayResult)
    }
    
//    func testSaveGetArrayObjectData() {
//        let object1 = Dummy()
//        let object2 = Dummy()
//        let object3 = Dummy()
//        let object4 = Dummy()
//        let object5 = Dummy()
//        
//        let theArray = [object1, object2, object3, object4, object5]
//        
//        FRCache.cacheArray(array: theArray,
//                           withKey: key)
//        let theArrayResult = FRCache.getCacheArray(withKey: key) as [Dummy]
//        
//        XCTAssertEqual(theArray, theArrayResult)
//    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
