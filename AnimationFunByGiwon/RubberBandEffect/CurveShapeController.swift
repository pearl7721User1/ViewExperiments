//
//  ViewShapeController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 30/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

enum CurveOrientation {
    case left, right, top, bottom, undetermined
}

class CurveShapeController: NSObject, RubberBandBehaviorHelperDelegate, CAAnimationDelegate {
    
    // TODO: - targetConstraint? what is it? should be here?
    private let targetConstraint: NSLayoutConstraint
    private weak var targetView: UIView?
    private let pathProvider = CurvePathProvider()
    private var maskLayer: CAShapeLayer = CAShapeLayer()
    
    struct ShapeStatus {
        var startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        var controlValue: CGFloat = 0.5
        var controlPoint = CGPoint.zero
        
    }
    
    private var shapeStatus = ShapeStatus()
    
    var maskLayerFrame = CGRect.zero {
        didSet {
            maskLayer.frame = maskLayerFrame
        }
    }
    
    init(targetConstraint: NSLayoutConstraint, targetView: UIView) {
        self.targetConstraint = targetConstraint
        self.targetView = targetView
        
        super.init()
        
        maskLayer.frame = targetView.bounds
        targetView.layer.mask = maskLayer
        
        self.updateMask()
        
    }
    
    private func updateMask(controlValue: CGFloat = 0.5, curveSize:CGFloat = 0) {
        
        let shapeStatus = newShapeStatus(maskLayer: maskLayer, controlValue: controlValue, curveSize: curveSize)
        self.shapeStatus = shapeStatus
        drawShapePath(on: &maskLayer, shapeStatus: shapeStatus)
    }
    
    func constantUpdated(to: CGFloat, curveMagnitude: CGFloat, curveControl: CGFloat, sender: Any) {
        
        // change view height
        targetConstraint.constant = to
        
        // update curve shape status
        self.updateMask(controlValue: curveControl, curveSize: curveMagnitude)
        
    }
    
    func snapBack(from fromConstant: CGFloat, to toConstant: CGFloat, sender: Any) {
        
        // generate control points out of the current control point
        let controlPoints = CurveControlValueGenerator.controlPoints(startPoint: shapeStatus.startPoint, endPoint: shapeStatus.endPoint, controlValue: shapeStatus.controlValue, controlPoint: shapeStatus.controlPoint)
        
        // add animations
        let paths = controlPoints.map({pathProvider.path(shapeLayer: maskLayer, controlPoint: $0, startPoint: self.shapeStatus.startPoint, endPoint: self.shapeStatus.endPoint, curveOrientation: .top)})
        if let _animationGroup = animationGroup(with: paths) {
            maskLayer.add(_animationGroup, forKey: nil)
        }
 
    }
    
    func animationDidStop(_ anim: CAAnimation,
                          finished flag: Bool) {
        
        // do completion
        
        
    }
}

extension CurveShapeController {
    
    fileprivate func newShapeStatus(maskLayer: CAShapeLayer, controlValue: CGFloat = 0.5, curveSize:CGFloat = 0) -> ShapeStatus {
        
        // get control value
        var startPoint = maskLayer.bounds.origin
        startPoint.y = startPoint.y + curveSize
        
        var endPoint = startPoint
        endPoint.x = maskLayer.bounds.maxX
        
        let controlPoint = CurveControlValueGenerator.controlPoint(startPoint: startPoint, endPoint: endPoint, controlValue: controlValue, curveSize: curveSize, curveOrientation: .top)
        
        
        let shapeStatus = ShapeStatus(startPoint: startPoint, endPoint: endPoint, controlValue: controlValue, controlPoint: controlPoint)
        return shapeStatus
    }
    
    fileprivate func drawShapePath(on mask: inout CAShapeLayer, shapeStatus: ShapeStatus) {
        
        let path = pathProvider.path(shapeLayer: mask, controlPoint: shapeStatus.controlPoint, startPoint: shapeStatus.startPoint, endPoint: shapeStatus.endPoint, curveOrientation: .top)
        mask.path = path.cgPath
        mask.fillColor = UIColor.red.cgColor
        mask.strokeColor = UIColor.green.cgColor
    }
    
    fileprivate func animationGroup(with paths:[UIBezierPath]) -> CAAnimationGroup? {
        
        // TODO: - create my own timing function
        guard paths.count == 6 else {
            print("wrong paths count for snap back animations")
            return nil
        }
        
        let animation1 = CABasicAnimation(keyPath: "path")
        animation1.duration = 0.1
        animation1.fromValue = paths[0].cgPath
        animation1.toValue = paths[1].cgPath
        animation1.beginTime = 0
        
        let animation2 = CABasicAnimation(keyPath: "path")
        animation2.duration = 0.05
        animation2.fromValue = paths[1].cgPath
        animation2.toValue = paths[2].cgPath
        animation2.beginTime = 0.1
        
        let animation3 = CABasicAnimation(keyPath: "path")
        animation3.duration = 0.05
        animation3.fromValue = paths[2].cgPath
        animation3.toValue = paths[3].cgPath
        animation3.beginTime = 0.15
        
        let animation4 = CABasicAnimation(keyPath: "path")
        animation4.duration = 0.05
        animation4.fromValue = paths[2].cgPath
        animation4.toValue = paths[3].cgPath
        animation4.beginTime = 0.2
        
        let animation5 = CABasicAnimation(keyPath: "path")
        animation5.duration = 0.05
        animation5.fromValue = paths[3].cgPath
        animation5.toValue = paths[4].cgPath
        animation5.beginTime = 0.25
        
        let animation6 = CABasicAnimation(keyPath: "path")
        animation6.duration = 0.05
        animation6.fromValue = paths[4].cgPath
        animation6.toValue = paths[5].cgPath
        animation6.beginTime = 0.30
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation1, animation2, animation3, animation4, animation5]
        animationGroup.duration = 0.35
        animationGroup.delegate = self
        
        return animationGroup
    }
}

