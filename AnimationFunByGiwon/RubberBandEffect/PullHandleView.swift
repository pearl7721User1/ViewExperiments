//
//  PlainViewA.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 28/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class PullHandleView: UIView {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint! {
        didSet {
            heightConstraint.constant = originalHeightValue
        }
    }
    private let originalHeightValue: CGFloat = 80
    private var rubberBandHelper: RubberBandBehaviorHelper
    
    private lazy var curveShapeController: CurveShapeController = {
        let curveShapeController = CurveShapeController(targetConstraint: heightConstraint, targetView: self)
        rubberBandHelper.delegate = curveShapeController
        return curveShapeController
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        
        rubberBandHelper = RubberBandBehaviorHelper(originalViewHeight: originalHeightValue)
        super.init(coder: aDecoder)
        
        // add pangesture
        let pangesture = UIPanGestureRecognizer(target: rubberBandHelper, action: #selector(rubberBandHelper.viewDragged))
        self.addGestureRecognizer(pangesture)
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        curveShapeController.maskLayerFrame = self.bounds
    }
}
