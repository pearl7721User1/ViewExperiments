//
//  CurvedMaskRenderer.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 27/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class CurvedMaskRendererForTesting: NSObject {

    enum CurveDirection {
        case left, right, top, bottom
    }
    
    func redraw(for shapeLayer: inout CAShapeLayer, curveDirection: CurveDirection, curveControlValue: CGFloat) {
        
        shapeLayer.path = curvePathAtTop(frame: shapeLayer.bounds, at: curveControlValue).cgPath
        
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
    
    private func curvePathAtTop(frame: CGRect, at normalizedPoint: CGFloat) -> UIBezierPath {
        
        let curvePath = UIBezierPath()
        let firstPoint = CGPoint(x: 0, y: 50)
        let endPoint = CGPoint(x: frame.maxX, y: 50)
        
        curvePath.move(to: firstPoint)
        
        // add curve
        let controlPoint = CGPoint(x:frame.width * normalizedPoint, y:0)
        curvePath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // add line to right bottom
        curvePath.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))
        
        // add line to left bottom
        curvePath.addLine(to: CGPoint(x: frame.minX, y: frame.maxY))
        
        // add line to start point
        curvePath.addLine(to: firstPoint)
        
        curvePath.close()
        
        return curvePath
    }
}
