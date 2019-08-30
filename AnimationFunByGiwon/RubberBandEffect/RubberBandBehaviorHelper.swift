//
//  RubberBandBehaviorHelper.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 28/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class RubberBandBehaviorHelper: NSObject {
    
    var targetConstraint: NSLayoutConstraint?
    var targetView: UIView?
    var constraintOriginalConstant: CGFloat = 0.0
    var rubberConstant: CGFloat = 100
    
    @IBAction func viewDragged(sender: UIPanGestureRecognizer) {
        let yTranslation = sender.translation(in: sender.view).y
        
        switch sender.state {
        case .began, .changed:
            
            let logScale = constraintOriginalConstant + rubberConstant * log10(abs(yTranslation/rubberConstant) + 1)
            print("log:\(logScale)")
            
            targetConstraint?.constant = logScale
            
        default:
            animateViewBackToLimit()
            break
        }
        
    }
    
    func animateViewBackToLimit() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            
            self.targetConstraint?.constant = self.constraintOriginalConstant
            self.targetView?.layoutIfNeeded()
            
        }, completion: nil)
    }
}
