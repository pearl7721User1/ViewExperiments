//
//  RubberBandBehaviorHelper.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 28/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

protocol RubberBandBehaviorHelperDelegate {
    func constantUpdated(to: CGFloat, curveMagnitude:CGFloat, curveControl:CGFloat, sender: Any)
    func bounceBack(to constant:CGFloat, sender: Any)
}


class RubberBandBehaviorHelper: NSObject {
    
    var delegate: RubberBandBehaviorHelperDelegate?
    var pulledViewHeight: CGFloat
    private let rubberConstant: CGFloat = 100
    
    init(originalViewHeight: CGFloat) {
        self.pulledViewHeight = originalViewHeight
    }
    
    @IBAction func viewDragged(sender: UIPanGestureRecognizer) {
        let yTranslation = sender.translation(in: sender.view).y
        let xLocation = sender.location(in: sender.view).x
        
        var normalizedXLocation: CGFloat {
            
            if let bounds = sender.view?.bounds {
                return xLocation / bounds.width
            }
            return 0.5
        }
        
        
        switch sender.state {
        case .began, .changed:
            
            guard yTranslation < 0 else {
                return
            }
            
            let rubberBandYTranslation = pulledViewHeight + rubberConstant * log10(-yTranslation/rubberConstant + 1)
            
            delegate?.constantUpdated(to: rubberBandYTranslation, curveMagnitude: rubberBandYTranslation - pulledViewHeight, curveControl: normalizedXLocation, sender: self)
            
            
        default:
            
            delegate?.bounceBack(to: pulledViewHeight, sender: self)
            
            break
        }
        
    }
    
}
