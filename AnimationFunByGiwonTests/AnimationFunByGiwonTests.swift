//
//  AnimationFunByGiwonTests.swift
//  AnimationFunByGiwonTests
//
//  Created by SeoGiwon on 15/10/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import XCTest

@testable import AnimationFunByGiwon
class AnimationFunByGiwonTests: XCTestCase {
    
    var controlValueGenerator = CurveControlValueGenerator()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let startPoint = CGPoint(x:0, y:48.713837)
        let endPoint = CGPoint(x:414, y:48.713837)
        
        
        let controlPoint1 = CGPoint(x:283.5, y:0)
        let controlPoint2 = CGPoint(x:252.900001, y:19.4855350)
        
        let result1 = CurveControlValueGenerator.oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint1, curveScale: 0.8)
        
        let result2 = CurveControlValueGenerator.oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint2, curveScale: 0.7)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
