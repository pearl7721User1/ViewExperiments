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
    
    func valueUpdated(sender: Any, x: CGFloat, originalHeight: CGFloat, updatedHeight: CGFloat) {
        
        // change view height
        targetConstraint.constant = updatedHeight
        
        // update mask
        curveRenderer.redraw(for: &maskLayer, curveDirection: .top, curveControlValue: x, curveHeight: updatedHeight-originalHeight)
    }
    
    func bounceBack(sender: Any, to constant: CGFloat) {
        
        var curveControlValueTemp: CGFloat = 0.5
        var curveHeightTemp: CGFloat = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            
            self.targetConstraint.constant = constant
            
            // update mask
            self.curveRenderer.redraw(for: &self.maskLayer, curveControlValue: 0.5, curveHeight: 0)
            
            self.targetView?.layoutIfNeeded()
            
        }, completion: nil)
    }
}
