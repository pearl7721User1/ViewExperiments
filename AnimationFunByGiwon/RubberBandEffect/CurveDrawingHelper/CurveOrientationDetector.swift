//
//  CurveOrientationDetector.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 17/10/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

struct CurveOrientationDetector {

    
    private var point = CGPoint.zero
    private var translation = CGPoint.zero
    var frame = CGRect.zero
    private (set) var orientation = CurveOrientation.undetermined
    
    mutating func dragged(to point:CGPoint, translation:CGPoint) {
        
        if orientation == .undetermined {
            self.point = point
            self.translation = translation
        }
        
        updateOrientation()
    }
    
    private mutating func updateOrientation() {
        
        if frame.contains(point) == false {
            
            // is it x or y?
            var isX = false
            var num = translation.y
            if abs(translation.x) > abs(translation.y) {
                isX = true
                num = translation.x
            }
            
            // direction?
            let isPositiveNum = num > 0 ? true : false
            
            if isX == true, isPositiveNum == true {
                orientation = .right
            } else if isX == true, isPositiveNum == false {
                orientation = .left
            } else if isX == false, isPositiveNum == true {
                orientation = .bottom
            } else {
                orientation = .top
            }
            
        }
    }
    
    
    
    mutating func reset() {
        self.point = CGPoint.zero
        self.translation = CGPoint.zero
        self.orientation = .undetermined
    }
}
