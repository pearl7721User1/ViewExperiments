//
//  ControlPointGenerator.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 10/10/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

struct CurveControlValueGenerator {
    
    struct CurvePointInfo {
        let originalControlPoint:CGPoint
        let controlValue:CGFloat
        let curveSize:CGFloat
        let curveOrientation:CurveOrientation
        let distanceOfStartAndEndPoint:CGFloat
    }    
    
    static func controlPoints(startPoint: CGPoint, endPoint: CGPoint, controlValue:CGFloat, controlPoint:CGPoint) -> [CGPoint] {
        
        // get oscilating control points
        var controlPoints = [CGPoint]()
        controlPoints.append(controlPoint)
        
        let controlPoint2 = oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint, curveScale: 0.7)
        controlPoints.append(controlPoint2)
        
        let controlPoint3 = oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint2, curveScale: 0.7)
        controlPoints.append(controlPoint3)
        
        let controlPoint4 = oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint3, curveScale: 0.5)
        controlPoints.append(controlPoint4)
        
        let controlPoint5 = oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint4, curveScale: 0.5)
        controlPoints.append(controlPoint5)
        
        let controlPoint6 = oppositeControlPoint(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint5, curveScale: 0)
        
        controlPoints.append(controlPoint6)

        return controlPoints
    }
    
    static func oppositeControlPoint(startPoint:CGPoint, endPoint:CGPoint, controlPoint:CGPoint, curveScale:CGFloat) -> CGPoint {
        
        // calculate the mid point
        let midPoint = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        
        let p = pow(controlPoint.x - midPoint.x, 2) + pow(controlPoint.y - midPoint.y, 2)
        
        let distanceToMidPoint = sqrt(p)
        
        let vectorMagnitude = distanceToMidPoint * 2 * curveScale
        
        print("vectorMagnitude:\(vectorMagnitude)")
        
        let pointer = CGPoint(x: midPoint.x - controlPoint.x, y: midPoint.y - controlPoint.y)
        
        // create a vector instance
        let vector = GiwonVector(pointer: pointer, magnitude: vectorMagnitude)
        
        let result = controlPoint.move(vector: vector)
        
        return result
    }
    
    static func controlPoint(startPoint:CGPoint, endPoint:CGPoint, controlValue:CGFloat, curveSize:CGFloat, curveOrientation: CurveOrientation) -> CGPoint {
        
        var controlPoint = CGPoint.zero
        var diff: CGFloat = 0
        
        switch curveOrientation {
        case .left:
            
            diff = startPoint.y - endPoint.y
            controlPoint = CGPoint(x:startPoint.x - curveSize, y:startPoint.y - diff * controlValue)
            
        case .right:
            
            diff = endPoint.y - startPoint.y
            controlPoint = CGPoint(x:endPoint.x + curveSize, y:startPoint.y + diff * controlValue)
            
        case .top:
            
            diff = endPoint.x - startPoint.x
            controlPoint = CGPoint(x:startPoint.x + diff * controlValue, y:startPoint.y - curveSize)
            
        case .bottom:
            
            diff = startPoint.x - endPoint.x
            controlPoint = CGPoint(x:startPoint.x - diff * controlValue, y:startPoint.y + curveSize)
        default:
            break
        }
        
        return controlPoint
        
    }
}


