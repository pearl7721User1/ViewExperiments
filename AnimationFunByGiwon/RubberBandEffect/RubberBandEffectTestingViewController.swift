//
//  RubberBandEffectTestingViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 28/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class RubberBandEffectTestingViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    private var curveShapeController: CurveShapeController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        curveShapeController = CurveShapeController(targetView: targetView)
    }
    

}
