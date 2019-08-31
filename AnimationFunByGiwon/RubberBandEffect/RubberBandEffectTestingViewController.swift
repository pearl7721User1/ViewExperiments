//
//  RubberBandEffectTestingViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 28/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class RubberBandEffectTestingViewController: UIViewController {

    var catImageViewController: CatImageViewController
    
    required init?(coder aDecoder: NSCoder) {
        catImageViewController = CatImageViewController.newInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addChild(catImageViewController)
        self.view.addSubview(catImageViewController.view)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var rect = self.view.bounds
        rect.origin = CGPoint(x:0, y:self.view.bounds.maxY - 80)
        catImageViewController.view.frame = rect
    }
}
