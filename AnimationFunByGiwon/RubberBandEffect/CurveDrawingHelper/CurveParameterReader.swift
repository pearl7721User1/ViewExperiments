//
//  CurveParameterReader.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 17/10/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

struct CurveParameterReader {
    
    let rubberConstant: CGFloat = 1000000
    
    func curveParameters(frame:CGRect, to point:CGPoint, with orientation:CurveOrientation) -> (curveSize:CGFloat, curveValue:CGFloat) {
        
        var curveSize: CGFloat = 0

        var offsetFromStartPoint = CGPoint.zero
        var curveSizeMightBe: CGFloat = 0
        
        var _curveControlValue: CGFloat = 0.5
        
        switch orientation {
        case .left:
            
            offsetFromStartPoint = CGPoint(x:frame.minX - point.x, y:frame.maxY - point.y)
            _curveControlValue = curveControlValue(pointValue: point.y, frameMin: frame.minY, frameMax:frame.maxY, param: offsetFromStartPoint.y)
            curveSizeMightBe =  offsetFromStartPoint.x
            
        case .right:
            offsetFromStartPoint = CGPoint(x:point.x - frame.maxX, y:point.y - frame.minY)
            _curveControlValue = curveControlValue(pointValue: point.y, frameMin: frame.minY, frameMax:frame.maxY, param: offsetFromStartPoint.y)
            curveSizeMightBe =  offsetFromStartPoint.x

        case .top:
            offsetFromStartPoint = CGPoint(x:point.x - frame.minX, y:frame.minY - point.y)
            _curveControlValue = curveControlValue(pointValue: point.x, frameMin: frame.minX, frameMax:frame.maxX, param: offsetFromStartPoint.x)
            curveSizeMightBe =  offsetFromStartPoint.y
            
        case .bottom:
            offsetFromStartPoint = CGPoint(x:frame.maxX - point.x, y:point.y - frame.maxY)
            _curveControlValue = curveControlValue(pointValue: point.x, frameMin: frame.minX, frameMax:frame.maxX, param: offsetFromStartPoint.x)
            curveSizeMightBe =  offsetFromStartPoint.y
            
        default:
            break
        }
        
        if curveSizeMightBe > 0 {
            
            // log?
            curveSize = rubberConstant * log10(curveSizeMightBe/rubberConstant + 1)
//            curveSize = log2(curveSizeMightBe + 1)
            
            // linear?
            // curveSize = curveSizeMightBe
        }
        
        return (curveSize:curveSize, curveValue:_curveControlValue)
/*
        let yTranslation = sender.translation(in: sender.view).y
        let xLocation = sender.location(in: sender.view).x
        
        var normalizedXLocation: CGFloat {
            
            if let bounds = sender.view?.bounds {
                return xLocation / bounds.width
            }
            return 0.5
        }
        
        let rubberBandYTranslation = pulledViewHeight + rubberConstant * log10(-yTranslation/rubberConstant + 1)
        
        switch sender.state {
        case .began, .changed:
            
            guard yTranslation < 0 else {
                return
            }
            
            delegate?.constantUpdated(to: rubberBandYTranslation, curveMagnitude: rubberBandYTranslation - pulledViewHeight, curveControl: normalizedXLocation, sender: self)
*/
    }
    
    private func curveControlValue(pointValue: CGFloat, frameMin: CGFloat, frameMax:CGFloat, param: CGFloat) -> CGFloat {
        
        var curveControlValue: CGFloat = 0.5
        
        if pointValue < frameMin {
            curveControlValue = 0
        } else if pointValue > frameMax {
            curveControlValue = 1
        } else {
            let d = frameMax - frameMin
            curveControlValue = param / d
        }
        
        return curveControlValue
    }
}
