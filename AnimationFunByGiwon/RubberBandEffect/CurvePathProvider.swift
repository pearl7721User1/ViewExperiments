//
//  CurvedMaskRenderer.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 27/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class CurvePathProvider: NSObject {    
    
    func path(shapeLayer: CAShapeLayer, controlPoint: CGPoint? = nil, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, curveOrientation:CurveOrientation = .top) -> UIBezierPath {
        
        var point1 = CGPoint.zero
        var point2 = CGPoint.zero
        let _startPoint = startPoint ?? CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.minY)
        let _endPoint = endPoint ?? CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.minY)
        let _controlPoint = controlPoint ?? CGPoint(x:(_endPoint.x - _startPoint.x) / 2, y:(_endPoint.y - _startPoint.y) / 2)
        
        switch curveOrientation {
        case .left:
            point1 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.minY)
            point2 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.maxY)
        case .right:
            point1 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.maxY)
            point2 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.minY)
        case .top:
            point1 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.maxY)
            point2 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.maxY)
        case .bottom:
            point1 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.minY)
            point2 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.minY)
        default:
            break
        }
        
        let curvePath = UIBezierPath()
        curvePath.move(to: _startPoint)
        
        // add curve
        curvePath.addQuadCurve(to: _endPoint, controlPoint: _controlPoint)
        curvePath.addLine(to: point1)
        curvePath.addLine(to: point2)
        
        curvePath.close()
        
        return curvePath
    }
/*
    func redraw(for shapeLayer: inout CAShapeLayer, controlPoint: CGPoint? = nil, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, curveOrientation:CurveControlValueGenerator.CurveOrientation = .top) {
        
        var point1 = CGPoint.zero
        var point2 = CGPoint.zero
        let _startPoint = startPoint ?? CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.minY)
        let _endPoint = endPoint ?? CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.minY)
        let _controlPoint = controlPoint ?? CGPoint(x:(_endPoint.x - _startPoint.x) / 2, y:(_endPoint.y - _startPoint.y) / 2)
        
        switch curveOrientation {
        case .left:
            point1 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.minY)
            point2 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.maxY)
        case .right:
            point1 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.maxY)
            point2 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.minY)
        case .top:
            point1 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.maxY)
            point2 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.maxY)
        case .bottom:
            point1 = CGPoint(x:shapeLayer.bounds.minX, y:shapeLayer.bounds.minY)
            point2 = CGPoint(x:shapeLayer.bounds.maxX, y:shapeLayer.bounds.minY)
        }
        
        let curvePath = UIBezierPath()
        curvePath.move(to: _startPoint)
        
        // add curve
        curvePath.addQuadCurve(to: _endPoint, controlPoint: _controlPoint)
        curvePath.addLine(to: point1)
        curvePath.addLine(to: point2)
        
        curvePath.close()
    }
*/
    
    /*
    enum CurveDirection {
        case left, right, top, bottom
    }
    
    
    
    func redraw(for shapeLayer: inout CAShapeLayer, curveDirection: CurveDirection = .top, curveControlValue: CGFloat = 0.5, curveMagnitude: CGFloat = 0) {
        
        shapeLayer.path = curvePathAtTop(frame: shapeLayer.bounds, curveControlValue:curveControlValue, curveMagnitude:curveMagnitude).cgPath
        
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor
        
        // rotate shape layer
        var numOfRotation = 0
        switch curveDirection {
        case .top:
            numOfRotation = 0
        case .right:
            numOfRotation = 1
        case .bottom:
            numOfRotation = 2
        case .left:
            numOfRotation = 3
        }
        
        let rotationAngle = CGFloat.pi/2.0 * CGFloat(numOfRotation)
        
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shapeLayer.transform = CATransform3DRotate(CATransform3DIdentity, rotationAngle, 0, 0, 1)
    }
    
    func curvePathAtTop(frame: CGRect, curveControlValue: CGFloat, curveMagnitude:CGFloat) -> UIBezierPath {
        
        let curvePath = UIBezierPath()
        let firstPoint = CGPoint(x: 0, y: curveMagnitude)
        let endPoint = CGPoint(x: frame.maxX, y: curveMagnitude)
        
        curvePath.move(to: firstPoint)
        
        // add curve
        let controlPoint = CGPoint(x:frame.width * curveControlValue, y:0)
        curvePath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // add line to right bottom
        curvePath.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))
        
        // add line to left bottom
        curvePath.addLine(to: CGPoint(x: frame.minX, y: frame.maxY))
        
        // add line to start point
        curvePath.addLine(to: firstPoint)
        
        curvePath.close()
        
        lastPath = curvePath
        
        return curvePath
    }
    
    */
}
