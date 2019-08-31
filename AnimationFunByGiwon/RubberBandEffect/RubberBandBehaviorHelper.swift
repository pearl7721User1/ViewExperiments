//
//  RubberBandBehaviorHelper.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 28/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

protocol RubberBandBehaviorHelperDelegate {
    func valueUpdated(sender: Any, x:CGFloat, originalHeight:CGFloat, updatedHeight:CGFloat)
    func bounceBack(sender: Any, to constant:CGFloat)
}


class RubberBandBehaviorHelper: NSObject {
    
    var delegate: RubberBandBehaviorHelperDelegate?
    var originalViewHeight: CGFloat
    private let rubberConstant: CGFloat = 100
    
    init(originalViewHeight: CGFloat) {
        self.originalViewHeight = originalViewHeight
    }
    
    @IBAction func viewDragged(sender: UIPanGestureRecognizer) {
        let yTranslation = sender.translation(in: sender.view).y
        let xLocation = sender.location(in: sender.view).x
        
        
        switch sender.state {
        case .began, .changed:
            
            guard yTranslation < 0 else {
                return
            }
            
            let rubberBandYTranslation = originalViewHeight + rubberConstant * log10(-yTranslation/rubberConstant + 1)

            delegate?.valueUpdated(sender: self, x: xLocation, originalHeight: originalViewHeight, updatedHeight: rubberBandYTranslation)
            
        default:
            
            delegate?.bounceBack(sender: self, to: originalViewHeight)
            
            break
        }
        
    }
    
}
