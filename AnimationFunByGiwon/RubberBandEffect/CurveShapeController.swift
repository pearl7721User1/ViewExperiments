//
//  ViewShapeController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 30/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class CurveShapeController: NSObject, RubberBandBehaviorHelperDelegate {
    
    private let targetConstraint: NSLayoutConstraint
    private weak var targetView: UIView?
    
    var maskLayerFrame = CGRect.zero {
        didSet {
            maskLayer.frame = maskLayerFrame
        }
    }
    
    init(targetConstraint: NSLayoutConstraint, targetView: UIView) {
        self.targetConstraint = targetConstraint
        self.targetView = targetView
        
        maskLayer.frame = targetView.bounds
        targetView.layer.mask = maskLayer
        
        curveRenderer.redraw(for: &maskLayer)
    }
    
    private let curveRenderer = CurvedMaskRenderer()
    private var maskLayer: CAShapeLayer = CAShapeLayer()
    
    func constantUpdated(to: CGFloat, curveMagnitude: CGFloat, curveControl: CGFloat, sender: Any) {
        
        // change view height
        targetConstraint.constant = to
        
        // update mask
        curveRenderer.redraw(for: &maskLayer, curveDirection: .top, curveControlValue: curveControl, curveMagnitude: curveMagnitude)
    }
    
    func bounceBack(to constant: CGFloat, sender: Any) {
        
        self.targetConstraint.constant = constant
        
        if let lastPath = curveRenderer.lastPath {
            
            let animation1 = CASpringAnimation(keyPath: "path")
            animation1.damping = 0.8
            animation1.initialVelocity = 0.8
            animation1.duration = 0.3
            animation1.fromValue = lastPath.cgPath
            animation1.toValue = curveRenderer.curvePathAtTop(frame: maskLayer.bounds, curveControlValue: 0.5, curveMagnitude: 0).cgPath
            
            maskLayer.add(animation1, forKey: "path")
            
            curveRenderer.redraw(for: &maskLayer)
            
        }
    }
}
