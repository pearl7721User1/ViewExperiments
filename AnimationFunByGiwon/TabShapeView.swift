//
//  TabShapeView.swift
//  TestOnCAShapeLayer
//
//  Created by GIWON1 on 2018. 3. 19..
//  Copyright © 2018년 GIWON1. All rights reserved.
//

import UIKit

class TabShapeView: UIView {

    enum CurveDirection {
        case left, right, top, bottom
    }
    
    var curveDirection = CurveDirection.top
    
    override func draw(_ rect: CGRect) {
        
        
        let curvePath = curvePathAtTop(frame: self.bounds, at:0.5)
        
        if let context = UIGraphicsGetCurrentContext() {
            draw(curvePath, frame: rect, at: .left, with: context)
        }
        
    }
    
    private func draw(_ path: UIBezierPath, frame: CGRect, at direction: CurveDirection, with context: CGContext) {
        
        context.saveGState()
        
        // rotate context
        var numOfRotation = 0
        switch direction {
            
        case .top:
            numOfRotation = 0
        case .right:
            numOfRotation = 1
        case .bottom:
            numOfRotation = 2
        case .left:
            numOfRotation = 3
        }
        
        for _ in 0..<numOfRotation {
            context.translateBy(x: frame.midX, y: frame.midY)
            context.rotate(by: CGFloat.pi/2.0)
            context.translateBy(x: -frame.midX, y: -frame.midY)
        }
        
        // add path
        context.addPath(path.cgPath)
        
        context.setFillColor(UIColor.red.cgColor)
        context.setStrokeColor(UIColor.green.cgColor)
        
        // draw path
        context.drawPath(using: .fillStroke)
        
        context.restoreGState()
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
