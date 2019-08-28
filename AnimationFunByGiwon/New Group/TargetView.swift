//
//  TabShapeView.swift
//  TestOnCAShapeLayer
//
//  Created by GIWON1 on 2018. 3. 19..
//  Copyright © 2018년 GIWON1. All rights reserved.
//

import UIKit

class TargetView: UIView {

    private var shapeLayer: CAShapeLayer = CAShapeLayer()
    private let renderer = CurvedMaskRenderer()
    
    var curveDirection = CurvedMaskRenderer.CurveDirection.top {
        didSet {
            redrawShapeLayer()
        }
    }
    
    var curveControlValue: CGFloat = 0.5 {
        didSet {
            redrawShapeLayer()
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.layer.addSublayer(shapeLayer)
    }
    
    override func draw(_ rect: CGRect) {        
        redrawShapeLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.frame = self.bounds
    }
    
    private func redrawShapeLayer() {
        renderer.redraw(for: &shapeLayer, curveDirection: curveDirection, curveControlValue: curveControlValue)
    }
    
}
