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

class CurveShapeController: NSObject, RubberBandGestureDelegate, CAAnimationDelegate {
    
    private let targetView: UIView
    private let pathProvider = CurvePathProvider()
    private var maskLayer: CAShapeLayer = CAShapeLayer()
    private var originalTargetViewFrame: CGRect
    
    private var curveOrientationDetector = CurveOrientationDetector()
    private let curveReader = CurveParameterReader()
    
    
    struct ShapeStatus {
        var startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        var controlValue: CGFloat = 0.5
        var controlPoint = CGPoint.zero
        var curveOrientation = CurveOrientation.undetermined
    }
    
    private var shapeStatus = ShapeStatus()
    
    var maskLayerFrame = CGRect.zero {
        didSet {
            maskLayer.frame = maskLayerFrame
        }
    }
    
    init(targetView: UIView) {
        self.targetView = targetView
        originalTargetViewFrame = targetView.frame
        
        super.init()
        
        // add gesture
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(viewDragged(sender:)))
        targetView.addGestureRecognizer(pangesture)
        
        sizeToFitTargetView()
        shapeMask()
        
    }
    
    func sizeToFitTargetView() {
        maskLayer.frame = targetView.bounds
        targetView.layer.mask = maskLayer
    }
    
    
    
    private func shapeMask(controlValue: CGFloat = 0.5, curveSize:CGFloat = 0, orientation:CurveOrientation = .undetermined) {
        
        let shapeStatus = newShapeStatus(maskLayer: maskLayer, controlValue: controlValue, curveSize: curveSize, curveOrientation: orientation)
        self.shapeStatus = shapeStatus
        drawShapePath(on: &maskLayer, shapeStatus: shapeStatus)
    }
    
    // MARK: - RubberBandGestureDelegate
    func gestureBegan(sender:Any) {
        originalTargetViewFrame = targetView.frame
    }
    
    func curveUpdated(orientation: CurveOrientation, curveSize: CGFloat, curveControl: CGFloat, sender: Any) {
        
        // change view frame
        switch orientation {
        
        case .left:
            targetView.frame.origin = CGPoint(x:originalTargetViewFrame.origin.x - curveSize, y:originalTargetViewFrame.origin.y)
            targetView.frame.size = CGSize(width:originalTargetViewFrame.size.width + curveSize, height: originalTargetViewFrame.size.height)
            
        case .right:
            targetView.frame.size = CGSize(width:originalTargetViewFrame.size.width + curveSize, height: originalTargetViewFrame.size.height)
        
        case .top, .undetermined:
            targetView.frame.origin = CGPoint(x:originalTargetViewFrame.origin.x, y:originalTargetViewFrame.origin.y - curveSize)
            targetView.frame.size = CGSize(width:originalTargetViewFrame.size.width, height: originalTargetViewFrame.size.height + curveSize)
            
        case .bottom:
            targetView.frame.size = CGSize(width:originalTargetViewFrame.size.width, height: originalTargetViewFrame.size.height + curveSize)
        
            
            break
        }

        sizeToFitTargetView()
        self.shapeMask(controlValue: curveControl, curveSize: curveSize, orientation:orientation)
        
    }
    
    func snapBack(sender: Any) {
        
        // generate control points out of the current control point
        let controlPoints = CurveControlValueGenerator.controlPoints(startPoint: shapeStatus.startPoint, endPoint: shapeStatus.endPoint, controlValue: shapeStatus.controlValue, controlPoint: shapeStatus.controlPoint)
        
        // add animations
        let paths = controlPoints.map({pathProvider.path(shapeLayer: maskLayer, controlPoint: $0, startPoint: self.shapeStatus.startPoint, endPoint: self.shapeStatus.endPoint, curveOrientation: self.shapeStatus.curveOrientation)})
        if let _animationGroup = animationGroup(with: paths) {
            maskLayer.add(_animationGroup, forKey: nil)
            maskLayer.path = paths.last?.cgPath
        }
        
    }
    
    
    func animationDidStop(_ anim: CAAnimation,
                          finished flag: Bool) {
        
        // do completion
        print("animationDidStop")
        
        // back to the original frame
        targetView.frame = originalTargetViewFrame
        
        // reset shape status
        sizeToFitTargetView()
        self.shapeMask()
        
    }
}

extension CurveShapeController {
    
    @IBAction func viewDragged(sender: UIPanGestureRecognizer) {

        let translation = sender.translation(in: sender.view)
        let location = sender.location(in: sender.view?.superview)
        
        switch sender.state {
            
        case .began:
            
            gestureBegan(sender: self)
            curveOrientationDetector.reset()
            curveOrientationDetector.frame = originalTargetViewFrame
            
        case .changed:
            
            curveOrientationDetector.dragged(to: location, translation: translation)
            let orientation = curveOrientationDetector.orientation
            
            let params = curveReader.curveParameters(frame: originalTargetViewFrame, to: location, with: orientation)
            
            curveUpdated(orientation: orientation, curveSize: params.curveSize, curveControl: params.curveValue, sender: self)
            
//            print("originalFrame:\(self.targetView.frame.origin.x), \(self.targetView.frame.origin.y), \(originalTargetViewFrame.size.width), \(originalTargetViewFrame.size.height), location:\(location.x),\(location.y)")
//            print("orientation:\(orientation)")
            print("param-curveSize:\(params.curveSize), curveValue:\(params.curveValue)")
            
            
//            delegate?.constantUpdated(to: rubberBandYTranslation, curveMagnitude: rubberBandYTranslation - pulledViewHeight, curveControl: normalizedXLocation, sender: self)
            
            
        default:
            
            
            snapBack(sender: self)
//            delegate?.snapBack(from: rubberBandYTranslation, to: pulledViewHeight, sender: self)
            
            break
        }
        
        
//        sender.setTranslation(CGPoint.zero, in: sender.view)
    }
    
    fileprivate func newShapeStatus(maskLayer: CAShapeLayer, controlValue: CGFloat = 0.5, curveSize:CGFloat = 0, curveOrientation:CurveOrientation) -> ShapeStatus {
        
        // get control value
        var startPoint = maskLayer.bounds.origin
        var endPoint = startPoint
        
        switch curveOrientation {
        case .left:
            startPoint = CGPoint(x:maskLayer.bounds.minX + curveSize, y:maskLayer.bounds.maxY)
            endPoint = CGPoint(x:maskLayer.bounds.minX + curveSize, y:maskLayer.bounds.minY)
        case .right:
            startPoint = CGPoint(x:maskLayer.bounds.maxX - curveSize, y:maskLayer.bounds.minY)
            endPoint = CGPoint(x:maskLayer.bounds.maxX - curveSize, y:maskLayer.bounds.maxY)
        case .top, .undetermined:
            startPoint = CGPoint(x:maskLayer.bounds.minX, y:maskLayer.bounds.minY + curveSize)
            endPoint = CGPoint(x:maskLayer.bounds.maxX, y:maskLayer.bounds.minY + curveSize)
        case .bottom:
            startPoint = CGPoint(x:maskLayer.bounds.maxX, y:maskLayer.bounds.maxY - curveSize)
            endPoint = CGPoint(x:maskLayer.bounds.minX, y:maskLayer.bounds.maxY - curveSize)
        }
        
        
        let controlPoint = CurveControlValueGenerator.controlPoint(startPoint: startPoint, endPoint: endPoint, controlValue: controlValue, curveSize: curveSize, curveOrientation: curveOrientation)
        
        let shapeStatus = ShapeStatus(startPoint: startPoint, endPoint: endPoint, controlValue: controlValue, controlPoint: controlPoint, curveOrientation:curveOrientation)
        return shapeStatus
    }
    
    fileprivate func drawShapePath(on mask: inout CAShapeLayer, shapeStatus: ShapeStatus) {
        
        let path = pathProvider.path(shapeLayer: mask, controlPoint: shapeStatus.controlPoint, startPoint: shapeStatus.startPoint, endPoint: shapeStatus.endPoint, curveOrientation: shapeStatus.curveOrientation)

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

