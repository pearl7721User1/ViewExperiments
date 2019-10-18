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
        case .top, .undetermined:
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
        
        return curvePath
    }

}
